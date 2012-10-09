require 'spec_helper'

describe "HomepageFooter" do

  before(:each) do
    create(:city, :name => "Singapore")
    create(:currency)
  end

  it "renders home page footer" do
    home_page_footer = Page.create({:page_title => "Home page - Footer", :page_url => 'home_page_footer', :description => "CONTENT CCCC", :active => true, :mandatory => true})
    visit "/"
    page.should have_content(home_page_footer.description)
  end

end