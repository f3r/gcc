module PreferenceHelper

  def current_city
    Preferences.current_city(current_user, cookies)
  end

  def current_currency
    Preferences.current_currency(current_user, cookies)
  end

  def get_current_language
    Preferences.current_language(current_user, cookies)
  end

  def get_current_size_unit
    Preferences.current_size_unit(current_user, cookies)
  end

  def get_current_speed_unit
    Preferences.current_speed_unit(current_user, cookies)
  end

  #TODO Remove this
  #Used in the Properties.new
  def get_size_unit_backend_compatible
    Preferences.current_size_unit_backend_compatible(current_user, cookies)
  end
end
