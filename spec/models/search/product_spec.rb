require 'spec_helper'

describe Search::Product do
  before(:each) do
    #@user = create(:user)
    @search = Search::Product.new

  end

  it "searches amenities" do
    am1 = create(:amenity, :id => 3)
    am1 = create(:amenity, :id => 4)
    am1 = create(:amenity, :id => 1)
    @search.amenity_ids = [3, 4, 1]

    @search.send(:prepare_conditions) # Protected method
    conditions = @search.instance_variable_get("@sql_conditions") # Look inside the object

    conditions[0][0].should  == "products.amenities_search like ?"
    conditions[0][1].should  == "%<1>%<3>%<4>%"
  end

  context "Price bounds" do
    before(:each) do
      @pt1 = create(:category)
      @search.currency = create(:currency,:currency_code => 'USD')
      @search.stub(:price_unit).and_return(:sale)
    end

    it "returns nil if min == max" do
      @p1 = create(:product, :category => @pt1, :price_sale => 1000, :published => true)
      @search.category_ids = [@pt1.id]
      @search.price_range_bounds.should == [nil, nil]
    end

    it "returns min and max" do
      @p1 = create(:product, :category => @pt1, :price_sale => 1000,:published => true)
      @p2 = create(:product, :category => @pt1, :price_sale => 1200,:published => true)
      @p3 = create(:product, :category => @pt1, :price_sale => 2000,:published => true)
      @search.category_ids = [@pt1.id]

      @search.price_range_bounds.should == [1000, 2000]
    end

    it "picks a smart filter" do
      #  min    max      fmin   fmax   fstep
      [
        [0,     1,      [0,     1,     1]],
        [1,     10,     [1,     10,    1]],
        [0,     900,    [0,     900,   50]],
        [100,   900,    [100,   900,   50]],
        [820,   2580,   [800,   2600,  100]],
        [11,    50,     [10,    50,    5]],
        [7090,  36690,  [5000,  40000, 5000]]
      ].each do |min, max, filter|
        @search.stub(:price_range_bounds).and_return([min, max])
        @search.price_filter.should == filter
      end
    end

  end
end
