require 'spec_helper'

describe Preferences do
  before(:each) do
    @user = create(:user)
    @city = create(:city)
    @currency = create(:currency)
  end

  it "returns the default city" do
    current_city = Preferences.current_city(nil, {})
    current_city.id.should == City.active.first.id
  end

  it "returns the default city from cookie" do
    current_city = Preferences.current_city(nil, {:pref_city_id => @city.id})
    current_city.id.should == @city.id
  end

  it "returns the default city from user preference" do
    user_city = create(:city)
    @user.preferences.city = user_city
    @user.save
    current_city = Preferences.current_city(@user, {})
    current_city.id.should == user_city.id
  end

  it "returns default language" do
    current_language = Preferences.current_language(nil, {})
    current_language.should == Preferences.get_default_language
  end

  it "returns default language from cookie" do
    current_language = Preferences.current_language(nil, {:locale => 'es'})
    current_language.should == 'es'
  end

  it "returns default language from user" do
    locale = create(:locale)
    @user.preferences.locale = locale
    @user.save
    current_language = Preferences.current_language(@user, {:locale => 'es'})
    current_language.should == locale.code
  end

  it "returns default currency" do
    curr = Preferences.current_currency(nil, {})
    curr.id.should == Currency.default.id
  end

  it "returns default currency from cookie" do
    curr = Preferences.current_currency(nil, {:currency => @currency.currency_code})
    curr.id.should == @currency.id
  end

  it "returns default currency from user" do
    user_curr = create(:currency)
    @user.preferences.currency = user_curr
    @user.save
    curr = Preferences.current_currency(@user, {:currency => @currency.currency_code})
    curr.id.should == user_curr.id
  end

  it "returns default size unit" do
    size_u = Preferences.current_size_unit(nil, {})
    size_u.should == Preferences.size_units.sqm
  end

  it "returns default size unit from cookie" do
    size_u = Preferences.current_size_unit(nil, {:size_unit => :sqf})
    size_u.should == Preferences.size_units.sqf
  end

  it "returns default size unit from user" do
    @user.preferences.size_unit = :sqm
    @user.save
    size_u = Preferences.current_size_unit(@user, {:size_unit => :sqf})
    size_u.should == Preferences.size_units.sqm
  end

  it "returns default speed unit" do
    speed_u = Preferences.current_speed_unit(nil, {})
    speed_u.should == Preferences.speed_units.kmh
  end

  it "returns default speed unit from cookie" do
    speed_u = Preferences.current_speed_unit(nil, {:speed_unit => :mph})
    speed_u.should == Preferences.speed_units.mph
  end

  it "returns default speed unit from user" do
    @user.preferences.speed_unit = :kmh
    @user.save
    speed_u = Preferences.current_speed_unit(@user, {:speed_unit => :mph})
    speed_u.should == Preferences.speed_units.kmh
  end

end
