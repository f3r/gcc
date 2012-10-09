require 'spec_helper'

describe Transaction do
  before(:each) do
    @usd = create(:currency, :currency_code => 'USD')
    Currency.stub(:default).and_return(@usd)
  	@inquiry = create(:inquiry)
  end

  context "Total Price" do
    before(:each) do
      Inquiry.any_instance.stub(:price).and_return(1000.to_money('USD'))
    end

    it "charges a flat booking fee" do
    	SiteConfig.stub(:charge_total).and_return(false)
    	SiteConfig.stub(:fee_amount).and_return(300)
    	SiteConfig.stub(:fee_is_fixed).and_return(true)
    	transaction = @inquiry.transaction
    	transaction.total_amount.should == 300
    end

    it "charges a % fee" do
    	SiteConfig.stub(:charge_total).and_return(false)
    	SiteConfig.stub(:fee_amount).and_return(10)
    	SiteConfig.stub(:fee_is_fixed).and_return(false)

    	transaction = @inquiry.transaction
    	transaction.total_amount.should == 100
    end

    it "charges the total + a flat fee" do
      SiteConfig.stub(:charge_total).and_return(true)
      SiteConfig.stub(:fee_amount).and_return(300)
      SiteConfig.stub(:fee_is_fixed).and_return(true)

      transaction = @inquiry.transaction
      transaction.total_amount.should == 1300
    end

    it "charges the total + a % fee" do
      SiteConfig.stub(:charge_total).and_return(true)
      SiteConfig.stub(:fee_amount).and_return(20)
      SiteConfig.stub(:fee_is_fixed).and_return(false)

      transaction = @inquiry.transaction
      transaction.total_amount.should == 1200
    end
  end

  context "Price Composition" do
    before(:each) do
      SiteConfig.stub(:charge_total).and_return(true)
      SiteConfig.stub(:fee_amount).and_return(10)
      SiteConfig.stub(:fee_is_fixed).and_return(false)
      @transaction = @inquiry.transaction
      Product.any_instance.stub(:money_price).and_return(20.to_money('USD'))
      Inquiry.any_instance.stub(:length_stay).and_return(4)
      Inquiry.any_instance.stub(:length_stay_type).and_return('hours')
    end

    it "#rate_display" do
      @transaction.rate_display.should == "<span class='iso-code'>USD</span> $20.0 per hour"
    end

    it "#total_amount_display" do
      @transaction.total_amount_display.should == "<span class='iso-code'>USD</span> $88.0"
    end

    it "#product_amount_display" do
      @transaction.product_amount_display.should == "<span class='iso-code'>USD</span> $80.0"
    end

    it "#fee_amount_display" do
      @transaction.fee_amount_display.should == "<span class='iso-code'>USD</span> $8.0"
    end

    it "#fee_description %" do
      @transaction.fee_description.should == '10% service fee'
    end

    it "#fee_description fixed" do
      SiteConfig.stub(:fee_is_fixed).and_return(true)
      @transaction.fee_description.should == 'Service fee'
    end
  end
end