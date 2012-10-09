module Admin::CitiesHelper
  def public_city_path(city)
    url_for("/#{city.slug}")
  end

  def city_links_column(city)
    html = link_to('Details', admin_city_path(city), :class => 'member_link')
    html << link_to('Edit', edit_admin_city_path(city), :class => 'member_link')
    html << link_to_if(city.active, 'View Public', public_city_path(city), :class => 'member_link', :target => '_blank')
  end

  def static_image_map(product, zoom=14, pin = false)
    return unless product.geocoded?
    latlon = "#{product.lat},#{product.lon}"
    url = "http://maps.googleapis.com/maps/api/staticmap?size=400x200&center=#{latlon}&zoom=#{zoom}&sensor=false"
    url << "&markers=size:mid|color:red|#{latlon}" if pin
    image_tag url
  end
end