class PageObserver < ActiveRecord::Observer

  def after_save(page)
    cache_config = page.cache_configs
    unless cache_config.nil?
      Rails.cache.write self.class.cache_key(page.page_url), page, cache_config
    end
  end
  
  def self.cache_key(page_url)
    "page_#{page_url}"
  end
end