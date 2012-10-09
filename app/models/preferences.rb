class Preferences < ActiveRecord::Base

  as_enum :size_unit, [:sqm, :sqf], :column => :size_unit_id
  as_enum :speed_unit, [:kmh, :mph], :column => :speed_unit_id

  attr_accessible :user, :locale, :currency, :size_unit_id, :speed_unit_id, :city
  belongs_to :user
  belongs_to :locale
  belongs_to :currency
  belongs_to :city


  def self.current_city(current_user, cookies)
    current_city = current_user.prefered_city if current_user.present? && current_user.prefered_city.present?
    current_city = self.get_city_from_cookie(cookies) if not current_city.present?
    current_city = City.active.first if not current_city.present?
    current_city
  end

  def self.current_language(current_user, cookies)
    current_language = current_user.prefered_language.code if current_user.present? && current_user.prefered_language.present?
    current_language = self.get_language_from_cookie(cookies) if current_language.blank?
    current_language = self.get_default_language if current_language.blank?
    current_language
  end

  def self.current_currency(current_user, cookies)
    current_currency = current_user.prefered_currency if current_user.present? && current_user.prefered_currency.present?
    current_currency = self.get_currency_from_cookie(cookies) if not current_currency.present?
    current_currency = Currency.default if not current_currency.present?
    current_currency
  end

  def self.current_size_unit(current_user, cookies)
    current_size_unit = current_user.prefered_size_unit if current_user.present?
    current_size_unit = self.get_size_unit_from_cookie(cookies) if current_size_unit.blank?
    current_size_unit = self.size_units.sqm if current_size_unit.blank?
    current_size_unit
  end

  #TODO Remove this
  SIZE_UNIT_CONVERSION_BACKEND = {0 => "meters", 1 => "feet"}
  def self.current_size_unit_backend_compatible(current_user, cookies)
    current_size_unit = self.current_size_unit(current_user, cookies)
    SIZE_UNIT_CONVERSION_BACKEND[current_size_unit]
  end

  def self.current_speed_unit(current_user, cookies)
    current_speed_unit = current_user.prefered_speed_unit if current_user.present?
    current_speed_unit = self.get_speed_unit_from_cookie(cookies) if current_speed_unit.blank?
    current_speed_unit = Preferences.speed_units.kmh if current_speed_unit.blank?
    current_speed_unit
  end

  def self.get_city_from_cookie(cookies)
    City.find(cookies[:pref_city_id]) if cookies[:pref_city_id].present?
  end

  def self.get_currency_from_cookie(cookies)
    Currency.find_by_currency_code(cookies[:currency]) if cookies[:currency].present?
  end

  def self.get_language_from_cookie(cookies)
    cookies[:locale]
  end

  def self.get_default_language
    'en'
  end

  def self.get_size_unit_from_cookie(cookies)
    self.size_units[cookies[:size_unit]] if cookies[:size_unit].present?
  end

  def self.get_speed_unit_from_cookie(cookies)
    Preferences.speed_units[cookies[:speed_unit]] if cookies[:speed_unit].present?
  end
end
