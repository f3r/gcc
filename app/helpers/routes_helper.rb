module RoutesHelper
  def seo_city_path(city)
    url_for("/#{city.slug}")
  end

  def seo_product_url(product, url_params = {})
    extra = product.title.dup
    extra.gsub!(/[^\x00-\x7F]+/, '') # Remove anything non-ASCII entirely (e.g. diacritics).
    extra.gsub!(/[^\w_ \-]+/i, '')   # Remove unwanted chars.
    extra.gsub!(/[ \-]+/i, '-')      # No more than one of the separator in a row.
    extra.gsub!(/^\-|\-$/i, '')      # Remove leading/trailing separator.
    extra.downcase!

    city = product.city

    city_product_url(url_params.merge(:city => city.slug, :id => "#{product.id}-#{extra}"))
  end
end