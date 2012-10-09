require 'spec_helper'

describe "TakeControl" do
  before(:each) do
    create(:city, :name => "Singapore")
  end

  it "should change current user" do
    @admin = create(:admin)
    @user = create(:user)

    @admin.controls_user = @user
    @admin.save!

    login_as @admin
    page.should have_content("You are now administering the account of #{@user.full_name}")

    @admin.controls_user = nil
    @admin.save!

    visit "/"
    page.should_not have_content("You are now administering the account of #{@user.full_name}")
  end
end