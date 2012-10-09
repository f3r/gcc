require 'spec_helper'

describe AlertsController do
  before(:each) do
    @user = create(:user)
    @city = create(:city)
    SiteConfig.stub(:product_class).and_return(Service)
    login_as @user
  end

  it "creates an alert" do
    expect {
      post :create, :alert => {:schedule => "monthly", :delivery_method =>"email", :search_attributes => {:city_id => @city.id}}
    }.to change(Alert, :count).by(1)
  end

  it "creates a search" do
    expect {
      post :create, :alert => {:schedule => "monthly", :delivery_method =>"email", :search_attributes => {:city_id => @city.id}}
    }.to change(Search::Base, :count).by(1)
  end

  it "creates a search of correct type" do
    post :create, :alert => {:schedule => "monthly", :delivery_method =>"email", :search_attributes => {:city_id => @city.id}}
    response.should be_redirect
    last_search = Search::Base.last
    last_search.class.should == SiteConfig.product_class.searcher
  end

  it "soft deletes an alert" do
    new_alert = @user.alerts.create(:schedule => "monthly", :delivery_method=>"email", :search_attributes => {:city_id => @city.id})
    expect {
      put :destroy, :id => new_alert.id
    }.to change(Alert, :count).by(-1)

    new_alert.reload
    new_alert.deleted_at.should_not be_nil
  end

  it "pauses an alert" do
    new_alert = @user.alerts.create(:schedule => "monthly", :delivery_method=>"email", :search_attributes => {:city_id => @city.id})
    new_alert.active = true
    new_alert.save
    post :pause, :id => new_alert.id
    response.should be_redirect
    new_alert.reload
    new_alert.active.should == false
  end

  it "unpauses an alert" do
    new_alert = @user.alerts.create(:schedule => "monthly", :delivery_method=>"email", :search_attributes => {:city_id => @city.id})
    new_alert.active = false
    new_alert.save
    post :unpause, :id => new_alert.id
    response.should be_redirect
    new_alert.reload
    new_alert.active.should == true
  end

end