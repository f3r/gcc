module PlacesHelper
  def place_size(place)
    html = ""
    unit = get_current_size_unit

    if unit  == "sqf" && place.size_sqf
      html << number_with_precision(place.size_sqf, :strip_insignificant_zeros => true, :precision => 1)
      html << t("units.square_feet_short")
    elsif unit == "sqm" && place.size_sqm
      html << number_with_precision(place.size_sqm, :strip_insignificant_zeros => true, :precision => 1)
      html << t("units.square_meters_short")
    end
    html
  end

  def place_price(place, per_what = :per_month)
    symbol, amount = place.price(current_currency, per_what)
    "#{current_currency.label}#{amount}"
  end

  def render_photo(photo)
    p = photo.photo

    photo_title = photo.name.present? ? truncate(photo.name, :length => 23) : t("places.wizard.photos.no_caption")
    html = content_tag :div, :class => 'photo_image', :id => "image-#{photo.id}" do
      image_tag(p.url(:small), :data => {
        :id    => photo.id,
        :large => p.url(:large),
        :name  => photo.name || '',
        :trunc_name => truncate(photo.name, :length => 23) || ''
      }).html_safe
    end
    html << content_tag(:p, photo_title)

    html
  end

  def location(place)
    [place['city_name'], place['country_name']].join(',')
  end

  def display_place_amenities(place)
    place_amenities = []
    all_amenities = amenities_group_1 + amenities_group_2 + amenities_group_3 + amenities_group_4
    all_amenities.each do |a|
      if place[a[1].to_s]
        place_amenities << a[0]
      end
    end

    place_amenities
  end

  # to faken cons to still iterate and display for the last image the first and second image
  def carousel_photoset(place)
    hacked_photo_set = place.photos.all
    hacked_photo_set << place.photos[0] << place.photos[1]
  end

  # TODO: unused, delete?
  def month_count(days)
    date = Date.today
    days_count = Time.days_in_month(date.month, date.year)
    months = 'none'
    unless days.nil? || days.eql?(0)
      if days < days_count
        months = pluralize(days, 'day')
      elsif days == days_count
        months = pluralize((days/days_count), 'month')
      elsif days > days_count
        month = days/days_count
        days_count = (date - Date.today.advance(:months => "-#{month}".to_i)).to_i
        months = "#{pluralize((days - days_count), 'day')}, #{pluralize((month), 'month')}"
      end
    end
    months
  end
end
