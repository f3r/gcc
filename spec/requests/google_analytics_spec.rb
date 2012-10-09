require 'spec_helper'

describe "Google Analytics" do
  before(:each) do
    @city = create(:city, :name => "Singapore")
    SiteConfig.stub(:product_class).and_return(Property)
  end

  it "shows the client's GA code if the client has submitted it" do
    SiteConfig.stub(:gae_tracking_code).and_return('UA-12345678-9')
    visit "/"
    page.should have_content(SiteConfig.gae_tracking_code)
  end

  it "shows tse GA code if we have submitted it" do
    SiteConfig.stub(:gae_tracking_code_tse).and_return('UA-98765432-1')
    visit "/"
    page.should have_content(SiteConfig.gae_tracking_code_tse)
  end

  it "doesn't show the client's GA code if the client hasn't submitted it" do
    SiteConfig.stub(:gae_tracking_code).and_return(nil)
    visit "/"
    page.should_not have_content("'_setAccount'")
  end

  it "doesn't show our GA code if we haven't submitted it" do
    SiteConfig.stub(:gae_tracking_code_tse).and_return(nil)
    visit "/"
    page.should_not have_content('b._setAccount')
  end
end