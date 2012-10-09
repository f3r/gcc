#coding: utf-8
module LookupsHelper
  CANCELLATION_POLICIES = {1 => :flexible, 3 => :strict}

  def cities_options
    cities = City.all.collect{|city| [city.complete_name, city.id]}
  end

  def currencies_options
    Currency.active.collect{|cur| [cur.label, cur.id]}
  end

  def currency_sign_of(code)
    currency = Currency.find_by_currency_code(code)
    if currency
      currency.label
    else
      code
    end
  end

  def cancellation_policies_select
    CANCELLATION_POLICIES.collect { |key, value| [t("places.cancellation_policies.#{value}"), key] }
  end

  def place_types_select
    # id, translated name
    PlaceType.all.map {|pt| [I18n.t("places.types.#{pt.slug}"), pt.id]}
  end

  def place_types_list
    # id, translated name, slug
    PlaceType.all.map {|pt| [I18n.t("places.types.#{pt.slug}"), pt.id, pt.slug]}
  end

  def max_guest_options
    [[t("places.search.guests", :count => 1), 1], [t("places.search.guests", :count => 3), 3], [t("places.search.guests", :count => 5), 5], [t("places.search.guests", :count => 10), 10]]
  end

  def cancellation_desc(place)
    t("places.cancellation_policies.#{LookupsHelper::CANCELLATION_POLICIES[place.cancellation_policy]}")
  end

  # Should be of this format:
  # {"date_end"=>[120]}
  def error_codes_to_messages(error_hash)
    
    return error_hash unless error_hash.kind_of?(Hash)
    
    ret = []
    error_hash.each do |field, error_codes|
      error_codes.each do |error_code|
        ret << "#{field.to_s.humanize}: #{t("errors.#{error_code}")}"
      end
    end

    ret
  end

end