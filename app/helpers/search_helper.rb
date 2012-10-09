module SearchHelper
  def sort_options
  	return @search.sort_options if @search
  	SiteConfig.product_class.searcher.new.sort_options
  end

  def search_results_count(results)
    t("products.search.results", :count => results.count)
  end
end

