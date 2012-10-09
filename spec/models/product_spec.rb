require 'spec_helper'

describe Product do
  context "Amenities" do
    before(:each) do
      @product = create(:product)
      @amenities = 3.times.collect{ create(:amenity) }
    end

    it "sets nested amenities" do
      @product.amenity_ids = [@amenities[0].id, @amenities[2].id]
      @product.reload
      @product.amenities.should == [@amenities[0], @amenities[2]]
    end

    it "updates nested amenities" do
      @product.amenities = [@amenities[0], @amenities[1]]
      @product.reload
      @product.amenity_ids = [@amenities[1].id, @amenities[2].id]
      @product.reload
      @product.amenities.should == [@amenities[1], @amenities[2]]
    end

    it "populates a searchable amenities field" do
      @product.amenities = [@amenities[1], @amenities[0]]
      @product.save
      s = @product.amenities_search
      s.should_not be_nil
      s.should == "<#{@amenities[0].id}>,<#{@amenities[1].id}>"
    end
  end

  context "#price" do
    before(:each) do
      @usd = create(:currency, :currency_code => 'USD')
      @sgd = create(:currency, :currency_code => 'SGD')
      @hkd = create(:currency, :currency_code => 'HKD')
      Product.stub(:price_unit).and_return(:per_month)
      @product = build(:product, :currency => @sgd, :price_per_month => '2000', :price_per_month_usd => '150000')
    end

    it "returns the price in the original currency" do
      symbol, amount = @product.price(@sgd)
      symbol.should == @sgd.symbol
      amount.should == @product.price_per_month
    end

    it "returns the price in usd (using the precalculated value)" do
      symbol, amount = @product.price(@usd)
      symbol.should == @usd.symbol
      amount.should == @product.price_per_month_usd / 100
    end

    it "converts to a 3rd currency" do
      @hkd.should_receive(:from_usd).with(1500).and_return(8000)

      symbol, amount = @product.price(@hkd)
      symbol.should == @hkd.symbol
      amount.should == 8000
    end

    it "returns the price as a money object" do
      price = @product.money_price
      price.cents.should == @product.price_per_month * 100
      price.currency_as_string.should == @sgd.currency_code
    end
  end

  context "Custom Fields" do
    before(:each) do
      create(:custom_field, :name => 'favorite_food')
      create(:custom_field, :name => 'favorite_film')
      @product = build(:product)
    end

    it "sets the custom field" do
      @product.custom_fields = {:favorite_food => 'pizza'}
      @product.custom_fields[:favorite_food].should == 'pizza'

      @product.save.should be_true
      @product.reload

      @product.custom_fields[:favorite_food].should == 'pizza'
    end

    it "updates fields independently" do
      @product.custom_fields = {:favorite_food => 'pizza', :favorite_film => 'Torrente'}
      @product.custom_fields[:favorite_film].should == 'Torrente'

      @product.custom_fields = {:favorite_food => 'hot dogs'}
      @product.custom_fields[:favorite_film].should == 'Torrente'
    end
  end

  context "Wizard" do
    before(:each) do
      @product = create(:product)
    end

    it "moves the wizard step forward" do
      @product.completed_steps.should == 0

      @product.wizard_step = 1
      @product.save
      @product.completed_steps.should == 1
    end

    it "tracks the max completed wizard step" do
      @product.update_attribute(:completed_steps, 2)

      @product.wizard_step = 1
      @product.save
      @product.completed_steps.should == 2
    end
  end

  context "Photos" do
    before(:each) do
      @product = create(:product)
    end

    it "publishes with no photos in config" do
      @product.published = true
      @product.save
      @product.published.should be_true
    end

    it "doesn't publish if product doesn't have enough photos" do
      site_config = SiteConfig.create!(:id => 1, :site_name => 'SquareStays', :listing_photos_count => 1)
      SiteConfig.stub(:instance).and_return(site_config)
      @product.published = true
      @product.save
      @product.published.should be_false
    end

    it "publishes if the product has enough photos" do
      site_config = SiteConfig.create!(:id => 1, :site_name => 'SquareStays', :listing_photos_count => 1)
      SiteConfig.stub(:instance).and_return(site_config)
      @product.published = true
      @product.photos = SiteConfig.listing_photos_count.times.collect{p = Photo.new; p.save(:validate => false); p}
      @product.save
      @product.published.should be_true
    end

  end

end
