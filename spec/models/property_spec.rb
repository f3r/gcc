require 'spec_helper'

describe Property do
  before(:each) do
    @usd = create(:currency, :currency_code => 'USD')
    @sgd = create(:currency, :currency_code => 'SGD')
    @hkd = create(:currency, :currency_code => 'HKD')
    @place = build(:property, :currency => @sgd, :price_per_month => '2000', :price_per_month_usd => '150000')
    Property.stub(:price_unit).and_return(:per_month)
  end

  it "geocodes the address" do
    product = @place.product
    product.should_receive(:geocode)
    @place.save
  end

  context "#price" do
    it "returns the price in the original currency" do
      symbol, amount = @place.price(@sgd)
      symbol.should == @sgd.symbol
      amount.should == @place.price_per_month
    end

    it "returns the price in usd (using the precalculated value)" do
      symbol, amount = @place.price(@usd)
      symbol.should == @usd.symbol
      amount.should == @place.price_per_month_usd / 100
    end

    it "converts to a 3rd currency" do
      @hkd.should_receive(:from_usd).with(1500).and_return(8000)

      symbol, amount = @place.price(@hkd)
      symbol.should == @hkd.symbol
      amount.should == 8000
    end
  end
end