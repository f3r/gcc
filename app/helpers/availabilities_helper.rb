module AvailabilitiesHelper
  def color_price(s, p) # self, place
    if !s['price_per_night']
      'red'
    elsif p['price_per_night'].nil? || s['price_per_night'] == p['price_per_night']
      'grey'
    elsif s['price_per_night'] > p['price_per_night']
      'blue'
    elsif s['price_per_night'] < p['price_per_night']
      'green'
    end
  end

  def date_formatted(d) # date
    ds = Date.parse(d)
    ds.strftime("%a %d/%B")
  end

  def price_availability(s, p) # self, place
    if s['availability_type'] == 1
      'unavailable / manual booking'
    else
      raw("New Price: <small class='currency-sign'>#{p.currency.label}</small> #{s['price_per_night']} per night")
    end
  end

  def price_availability_plain(s, p) # self, place
    if s['availability_type'] == 1
      'unavailable / manual booking'
    else
      "New Price: #{p.currency.label} #{s['price_per_night']} per night"
    end
  end

  def price_availability_plain_calendar(s, p) # self, place
    if s['availability_type'] != 1
      "#{p.currency.label} #{s['price_per_night']} / night"
    else
      ""
    end
  end
end
