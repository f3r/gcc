namespace :sitemap_submission do
  desc "Push sitemap to search engines"
  task  :submit_sitemap => :environment do
    SITE_URL = SiteConfig.site_url
    
    SEARCH_ENGINES = {
      :google => "http://www.google.com/webmasters/tools/ping?sitemap=%s",
      :bing => "http://www.bing.com/webmaster/ping.aspx?siteMap=%s",
    }
    SEARCH_ENGINES.each do |name, url|
      request = url % CGI.escape("#{SITE_URL}/sitemap.xml")  
      if Rails.env == "production"
        response = Net::HTTP.get_response(URI.parse(request))
      end
    end
  end
end