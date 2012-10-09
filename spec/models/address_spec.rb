require 'spec_helper'

describe Address do
  before(:each) do
    @user = create(:user)
    @address = build(:address, :user => @user)
  end

  it "geolocalizes the address" do
    @address.should_receive :geocode
    @address.bussiness_address.should be_present
    @address.save
  end
  
end