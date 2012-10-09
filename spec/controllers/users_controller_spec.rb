require 'spec_helper'

describe UsersController do
  before(:each) do
    @user = create(:user)
    login_as @user
  end

  # it "shows my profile" do
  #   get :index
  #   response.should be_success
  # end
end
