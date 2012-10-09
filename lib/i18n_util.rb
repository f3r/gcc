require 'i18n/backend/active_record'
class I18nUtil

  # Create tanslation records from the YAML file.
  # Will create the required locales if they do not exist.
  def self.load_from_yml(file_name)
    data = YAML::load(IO.read(file_name))
    data.each do |code, translations|
      unless code
        puts "WARNING: Yaml file without code: #{file_name}"
      end
      if locale = I18n.available_locales.include?(code.to_sym) ? code : nil
        translations_array = extract_translations_from_hash(translations)
        translations_array.each do |key, value|
          pluralization_index = 1
          key.gsub!('.one', '') if key.ends_with?('.one')
          if key.ends_with?('.other')
            key.gsub!('.other', '')
            pluralization_index = 0
          end
          # We create the translations for Arrays and individual ones
          if value.is_a?(Array)
            value.each_with_index do |v, index|
              create_translation(locale, key, index, v) unless v.nil?
            end
          else
            create_translation(locale, key, pluralization_index, value)
          end
        end
      else
        puts "WARNING: Locale not found: #{code} -- #{file_name}"
      end
    end
  end

  # Finds or creates a translation record and updates the value
  def self.create_translation(locale, key, pluralization_index, value)
    # find existing record by hash key
    translation = Translation.find_by_locale_and_key(locale, key)
    # If it doesn't exist, we create a new one
    if !translation
      # We should remove the callbacks on save so that we dont run into
      # problems by clearing memcached too often
      Translation.skip_callback(:save, :after, :delete_cache)
      Translation.create!(:locale => locale, :key => key, :value => value)
      Translation.set_callback(:save, :after, :delete_cache)
      puts "Translation: created from yaml (#{locale}.#{key})" unless Rails.env.test?
    else
      # If it exists, we only update it if the user hasn't modify it
      if translation.modified?
        puts "Translation: WARNING conflict on (#{locale}.#{key})" unless Rails.env.test?
      else
        translation.update_column(:value, value) if value != translation.value
      end
    end
  end

  def self.extract_translations_from_hash(hash, parent_keys = [])
    (hash || {}).inject([]) do |keys, (key, value)|
      full_key = parent_keys + [key]
      if value.is_a?(Hash)
        # Nested hash
        keys += extract_translations_from_hash(value, full_key)
      elsif !value.nil?
        # String leaf node
        keys << [full_key.join("."), value]
      end
      keys
    end
  end

end