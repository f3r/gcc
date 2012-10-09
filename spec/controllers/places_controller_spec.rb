require 'spec_helper'

describe ListingsController do
  before(:each) do
    @user  = create(:user)
    @agent = create(:agent)
    @city = create(:city)
    @category = create(:category)
    @currency = create(:currency)
    SiteConfig.stub(:product_class).and_return(Property)
  end

  context "Creation" do
    it "creates a place" do
      login_as @agent
      expect {
        post :create, :listing => attributes_for(:property, :city_id => @city.id, :category_id => @category.id, :currency_id => @currency.id)
        response.should be_redirect
      }.to change(Property, :count).by(1)
    end

    it "doens't create a place with validation errors" do
      login_as @agent
      expect {
        post :create, :listing => attributes_for(:property, :title => nil, :city_id => @city.id, :category_id => @category.id, :currency_id => @currency.id)

        response.should be_success
      }.to_not change(Property, :count)

      assigns(:resource).errors_on(:title).should be_true
    end
  end

  context "Wizard" do
    before(:each) do
      @place = create(:property, :user => @agent)
    end

    it "won't allow Guest to edit a place he doesn't own" do
      login_as @user
      expect {
        get :edit, :id => @place.id
      }.to raise_error(ActiveRecord::RecordNotFound)
    end

    it "shows wizard for place" do
      login_as @agent
      get :edit, :id => @place.id
      response.should be_success
      assigns(:resource).should == @place
    end

    it "updates a place field" do
      login_as @agent
      xhr :put, :update, :id => @place.id, :listing => {:num_bathrooms => 3}
      response.should be_success

      @place.reload
      @place.num_bathrooms.should == 3
    end

    it "updates a place size" do
      login_as @agent
      xhr :put, :update, :id => @place.id, :listing => {:size => 100}
      response.should be_success

      @place.reload

      @place.size.should == 100
    end

    it "unpublishes a place" do
      login_as @agent

      @place = create(:published_place, :user => @agent)
      put :unpublish, :id => @place.id
      @place.reload

      @place.should_not be_published

      put :publish, :id => @place.id
      @place.reload

      @place.should be_published
    end

    it "changes currency" do
      login_as @agent
      @place = create(:published_place, :user => @agent)

      put :update_currency, :id => @place.id, :listing => {:currency_id => @currency.id}
      @place.reload

      @place.currency.should == @currency
    end
  end

  context "Management" do
    before(:each) do
      @place = create(:property, :user => @agent)
    end

    it "shows my places" do
      login_as @agent
      get :index
      response.should be_success

      assigns(:collection).count.should == 1
    end

    it "shows place preview to owner" do
      login_as @agent
      get :show, :id => @place.id
      response.should be_success

      assigns(:resource).should == @place
    end

    it "won't allow Guest to see a place he doesn't own" do
      login_as @user
      expect {
        get :show, :id => @place.id
      }.to raise_error(ActiveRecord::RecordNotFound)
    end

    it "deletes a place" do
      login_as @agent
      expect {
        post :destroy, :id => @place.id
        response.should be_redirect
      }.to change(Property, :count).by(-1)
    end

    it "cannot delete somebody elses place" do
      login_as @user
      expect {
        post :destroy, :id => @place.id
      }.to raise_error(ActiveRecord::RecordNotFound)
    end
  end
end
