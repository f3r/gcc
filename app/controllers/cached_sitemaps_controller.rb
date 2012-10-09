class CachedSitemapsController < SitemapsController

  # Get the siteurl from the config - rather than guessing it
  def default_url_options
    {:host => SiteConfig.site_url.gsub('http://', ''),
     :port => false}
  end

  layout false

  before_filter :set_headers
  include ProductsHelper

  caches_action :sitemap, {:expires_in => 24.hours}, :cache_path => "sitemap-xml"

  protected
  # When the page is cached, rails processes the action as html and sends the headers accordingly
  def set_headers
    headers["Content-Type"] = "application/xml; charset=utf-8"
    if not ActionController::Base.perform_caching  or not Rails.cache.exist? ActiveSupport::Cache.expand_cache_key "sitemap-xml", :views
      headers["Last-Modified"] = DateTime.now.httpdate
    end
  end
end
