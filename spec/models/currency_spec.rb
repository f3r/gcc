require 'spec_helper'

describe Currency do
  it "can be instantiated" do
    Currency.new.should be_an_instance_of(Currency)
  end

  it "finds currencies by symbol" do
    currency = Currency.where(:symbol => 'INR')
    currency.should_not be_nil
  end

  it "check default currency status is false" do
    currency = Currency.create(:name => "Indian Rupee", :symbol => 'INR', :country => 'India', :currency_code => "INR", :currency_abbreviation => "INR")
    currency.active.should == false
  end

  it "check currency status is true" do
    currency = Currency.create(:name => "Indian Rupee", :symbol => 'INR', :country => 'India', :currency_code => "INR", :currency_abbreviation => "INR", :active => true)
    currency.active.should == true
  end

  it "finds currency,deactivate it and check status" do
    currency = Currency.create(:name => "Indian Rupee", :symbol => 'INR', :country => 'India', :currency_code => "INR", :currency_abbreviation => "INR", :active => true)
    currency.deactivate!
    currency.active.should == false
  end

  it "finds currency, activate it and check status" do
    currency = Currency.create(:name => "Indian Rupee", :symbol => 'INR', :country => 'India', :currency_code => "INR", :currency_abbreviation => "INR")
    currency.activate!
    currency.active.should == true
  end

  it "finds currency, check the method label" do
    currency = Currency.create(:name => "Indian Rupee", :symbol => 'INR', :country => 'India', :currency_code => "INR", :currency_abbreviation => "INR",:active => true)
    currency.label.should == 'INR INR'
  end

  context "Conversion" do
    it "converts from usd", :external => true do
      currency = create(:currency, :currency_code => 'INR')
      amount_inr = currency.from_usd(1000)
      amount_inr.should_not be_nil
    end

    it "converts to usd", :external => true do
      currency = create(:currency, :currency_code => 'AUD')
      amount = currency.to_usd(1000)
      amount.should_not be_nil
    end
  end
end