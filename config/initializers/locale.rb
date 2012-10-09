#require 'i18n/backend/active_record'
I18n.default_locale = :en
# I18n.backend.class.send(:include, I18n::Backend::Fallbacks)
#active_record_backend = I18n::Backend::ActiveRecord.new
# active_record_backend.class.send(:include, I18n::Backend::Fallbacks)
#I18n::Backend::ActiveRecord.send :include, I18n::Backend::Cache
#I18n.cache_store = Rails.application.config.i18n_cache_store
#I18n.backend = I18n::Backend::Chain.new(active_record_backend, I18n.backend)