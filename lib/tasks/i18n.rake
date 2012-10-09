require File.dirname(__FILE__) + '/../i18n_util.rb'

namespace :i18n do

  namespace :populate do

    # Reads all the i18n yaml files and updates translations
    desc 'Populate the locales and translations tables from all Rails Locale YAML files. Can set LOCALE_YAML_FILES to comma separated list of files to overide'
    task :from_rails => :environment do

      # imports selected files or loadpath
      # yaml_files = ENV['LOCALE_YAML_FILES'] ? ENV['LOCALE_YAML_FILES'].split(',') : I18n.load_path
      # yaml_files.find_all{|file|File.extname(file) == '.yml'}.each do |file|
        # I18nUtil.load_from_yml file
      # end

      yaml_files = Dir['config/locales/**/*.yml']
      yaml_files.find_all{|file|File.extname(file) == '.yml'}.each do |file|
        I18nUtil.load_from_yml file unless (file.include?("devise") or file.include?("app_defaults"))
      end
    end

    desc 'Populate the locales and translations. Requires LOCALE_YAML_FILES with a comma separated list of files'
    task :from_files => :environment do
      # imports selected files
      # Ex. rake i18n:populate:from_files LOCALE_YAML_FILES=config/locales/mailers/en.yml
      if ENV['LOCALE_YAML_FILES']
        yaml_files = ENV['LOCALE_YAML_FILES'].split(',')
        yaml_files.find_all{|file|File.extname(file) == '.yml'}.each do |file|
          I18nUtil.load_from_yml file
        end
      else
        puts "must set LOCALE_YAML_FILES"
      end
    end

  end

end
