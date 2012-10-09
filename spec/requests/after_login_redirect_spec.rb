require 'spec_helper'

describe "AfterLoginRedirect" do
  before(:each) do
    create(:city, :name => "Singapore")
    create(:currency)
  end

  context "User login" do
    before(:each) do
      @agent = create(:agent)
    end

    it "user with no listing redirected to new listing url" do
      login_as @agent
      current_path.should == "/listings/new"
    end

    it "user with a listing redirected root url" do
      SiteConfig.stub(:product_class).and_return(Property)
      prop = create(:property, :user => @agent)
      login_as @agent
      current_path.should == "/"
    end
  end

  context "Admin login" do
    before(:each) do
      @admin = create(:admin)
    end

    it "should be redirected to /admin" do
      visit '/admin/login'
      fill_in 'admin_user[email]',    :with => @admin.email
      fill_in 'admin_user[password]', :with => @admin.password
      click_button 'Login'
      current_path.should == "/admin"
    end
  end
end
