module RoutesHelper
  def seo_city_path(city)
    url_for("/#{city.slug}")
  end

  def seo_product_url(product, url_params = {})
    extra = product.title.dup
    extra = clean_it(extra)
    city = product.city

    city_product_url(url_params.merge(:city => city.slug, :id => "#{product.id}-#{extra}"))
  end

  def seo_club_url(club, url_params = {})
    extra = club.name.dup
    extra = clean_it(extra)
    city = club.city
    city_club_url(url_params.merge(:city => city.slug, :id => "#{club.id}-#{extra}"))
  end

  private
  def clean_it(str)
    str.gsub!(/[^\x00-\x7F]+/, '') # Remove anything non-ASCII entirely (e.g. diacritics).
    str.gsub!(/[^\w_ \-]+/i, '')   # Remove unwanted chars.
    str.gsub!(/[ \-]+/i, '-')      # No more than one of the separator in a row.
    str.gsub!(/^\-|\-$/i, '')      # Remove leading/trailing separator.
    str.downcase!
  end
end