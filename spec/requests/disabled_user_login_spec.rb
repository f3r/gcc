require 'spec_helper'

describe "DisabledUserLogin" do
  before(:each) do
    create(:city, :name => "Singapore")
  end

  it "shoud not be allowed to login" do
    @user = create(:user)
    @user.disable

    login_as @user

    page.should have_content("Your account has been disabled")
  end
end
