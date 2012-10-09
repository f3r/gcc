class Translation < ActiveRecord::Base
  scope :template,   where("`translations`.`key` LIKE ?", 'template.%')
  scope :places,     where("`translations`.`key` LIKE ?", 'places.%')
  scope :users,      where("`translations`.`key` LIKE ?", 'users.%')
  scope :workflow,   where("`translations`.`key` LIKE ?", 'workflow.%')
  scope :inquiries,  where("`translations`.`key` LIKE ?", 'inquiries.%')
  scope :messages,   where("`translations`.`key` LIKE ?", 'messages.%')
  scope :mailers,    where("`translations`.`key` LIKE ?", 'mailers.%')

# TODO: revert this back asap!!
#  validate      :validate_placeholders
  after_save    :delete_cache
  after_destroy :delete_cache

  has_many :versions, :class_name => 'TranslationVersion', :foreign_key => "translation_id", :order => "id DESC", :dependent => :destroy

  validates_presence_of :locale, :key

  before_update do |r|
    r.versions.create({:value => r.value_was}) if r.value_changed?
  end

  # Was changed from the admin interface?
  def modified?
    self.versions.any?
  end

  def other_language(locale)
    translation = Translation.where(:key => self.key, :locale => locale).first
  end

  private
  # TODO: get cache_key name
  def delete_cache
    # namespace = "i18n"
    # Rails.cache.delete("i18n/#{namespace}/#{self.locale}/#{self.key.hash}/")
    # /#{USE_INSPECT_HASH ? options.inspect.hash : options.hash}
    logger.debug "Cleaning cache"
    I18n.cache_store.clear
  end

  def validate_placeholders
    new_placeholders = Array.new
    current_value = self.value
    key = self.key

    # Translation from YML files
    yml_backend = I18n::Backend::Simple.new
    yml_translation = yml_backend.translate(:en, key)

    # Dont validate pluralized translations
    return true if !yml_translation.kind_of?(String)

    # Default placeholders
    allowed_placeholders = options_with_replacements({}).keys

    # Existing placeholders
    existing_placeholders = interpolation_keys (yml_translation) if yml_translation.present?

    # Newly added placeholders
    new_placeholders = interpolation_keys(current_value) if current_value.present?

    if existing_placeholders.present?
      allowed_placeholders += existing_placeholders
      allowed_placeholders.uniq!
    end

    if new_placeholders.present?
      non_allowed = new_placeholders - allowed_placeholders
      if non_allowed.present?
        errors.add(:value, I18n.t('errors.translations.placeholders_not_allowed'))
        return false
      end
    end
    return true
  end

  def interpolation_keys( string )
    keys = Array.new
    if string.kind_of?(String)
      values = string.scan(/\%{(.*?)\}/)
      if values.present?
        values.each do |key|
          keys << key[0].to_sym
        end
      end
    end
    keys
  end
end