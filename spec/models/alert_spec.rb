require 'spec_helper'

describe Alert do
  before(:each) do
    @user = create(:user)
  end

  it "creates saves an alert" do
    new_alert = @user.alerts.create(:schedule => "monthly", :query => {'test'=>'test'})
    new_alert.should be_persisted
    new_alert.search_code.should_not be_nil
    new_alert.alert_type.should == SiteConfig.product_class.name
  end

  context "search results" do
    before(:each) do
      SiteConfig.stub(:product_class).and_return(Property)
      Property.stub(:price_unit).and_return(:per_month)

      @pt1 = create(:category)
      @pt2 = create(:category)

      @p1 = create(:published_place, :category => @pt1, :price_per_month => 1000)
      @p2 = create(:published_place, :category => @pt2, :price_per_month => 4990)
      @p3 = create(:published_place, :category => @pt1, :price_per_month => 3000)

      @search = Search::Property.new
      @search.category_ids = [@pt1.id]

      @alert1 = @user.alerts.create(:schedule => "monthly", :query => {'test'=>'test'}, :search => @search)

    end

    it "returns new results" do
      @alert1.get_results({:search_type => "new_results"}).count.should == 2
    end

    it "returns recently added results" do
      @alert1.delivered_at = Time.now
      @alert1.save
      new_prop = create(:published_place, :category => @pt1, :price_per_month => 1500, :created_at => Time.now + 1.day)
      @alert1.get_results({:search_type => "recently_added"}).count.should == 1
    end

    it "excludes the previous results" do
      res = @alert1.get_results({:search_type => "new_results"})
      @alert1.get_results({:search_type => "recently_added"}, res).count.should == 0
    end

    it "excludes the previous send results" do
      res = @alert1.get_results({:search_type => "new_results"})
      @alert1.update_delivered(res)

      #Again take the results
      res = @alert1.get_results({:search_type => "new_results"}).count.should == 0
    end

    it "excludes the previous send results and adds the new" do
      res = @alert1.get_results({:search_type => "new_results"})
      @alert1.update_delivered(res)
      # A new prop comes in that satisfies the search
      new_prop = create(:published_place, :category => @pt1, :price_per_month => 1500)
      #Again take the results
      res = @alert1.get_results({:search_type => "new_results"}).count.should == 1
    end

  end
end
