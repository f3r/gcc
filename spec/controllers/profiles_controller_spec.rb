require 'spec_helper'

describe ProfilesController do
  before(:each) do
    @user = create(:user)
    login_as @user
  end

  context "Information" do
    it "shows user profile" do
      get :show
      response.should be_success
      assigns(:user).should == @user
    end

    it "show user profile edit page" do
      get :edit
      response.should be_success
      assigns(:user).should == @user
    end

    it "updates the user information" do
      post :update, :user => {
        :first_name => 'First Name'
      }
      response.should be_redirect
      @user.reload
      @user.first_name.should == 'First Name'
    end
  end

  context "Address" do
    it "stores the user address" do
      city = create(:city)
      post :update, :user => {
        :address_attributes => {
          :street => 'Ayer Rajah',
          :city_id => city.id,
          :country => 'SG',
          :zip => '1123'
        }
      }
      response.should be_redirect
      @user.reload
      address = @user.address
      address.should_not be_nil
      address.street.should == 'Ayer Rajah'
    end

    it "updates the user address" do
      @address = create(:address, :user => @user)
      @user.address.should be_present

      put :update, :user => {
        :address_attributes => {
          :zip => '2323'
        }
      }
      response.should be_redirect
      @user.reload
      @user.address.zip.should == '2323'
    end
  end

  context "Password" do
    it "changes the user password" do
      post :update, :user => {
        :password => 'secret',
        :password_confirmation => 'secret'
      }
      response.should be_redirect
      @user.reload
      @user.should be_valid_password('secret')
    end

    it "doesn't change the password without correct confirmation" do
      post :update, :user => {
        :password => 'secret',
        :password_confirmation => 'sercet'
      }
      response.should be_success
      @user.reload
      @user.should_not be_valid_password('secret')
    end
  end
end
