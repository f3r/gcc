DynamicSitemaps::Sitemap.draw do
  # default per_page is 50.000 which is the specified maximum.
  # TODO
  # Will move this config
  per_page 1000

  url root_url, :last_mod => DateTime.now, :change_freq => 'daily', :priority => 1
  
  #Have the active cities in the sitemap
  City.active.each do |city|
    url "#{root_url}#{city.slug}", :change_freq => 'monthly', :priority => 0.6
  end
  
  #Get the cmspages linked with the menu sections
  Page.active.each do |page|
    url "#{root_url}#{page.page_url}", :change_freq => 'monthly', :priority => 0.7
  end
  
  SiteConfig.product_class.published.each do |prod|
    url seo_product_url(prod), :last_mod => prod.updated_at, :change_freq => 'monthly', :priority => 0.8
  end

end