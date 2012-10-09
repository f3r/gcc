module DynamicSitemaps
  class CacheSweeper < ActiveRecord::Observer
    
    def after_create(resource)
      expire_cache_for_sitemaps
    end
    
    def after_save(resource)
      expire_cache_for_sitemaps
    end

    def after_destroy(resource)
      expire_cache_for_sitemaps
    end

    private
    def expire_cache_for_sitemaps
        Rails.cache.delete expand_key, {} if ActionController::Base.perform_caching
    end
    
    def expand_key
      ActiveSupport::Cache.expand_cache_key "sitemap-xml", :views
    end  

    #from http://broadcastingadam.com/2011/05/advanced_caching_in_rails/ 
  end
end