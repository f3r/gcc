require 'spec_helper'

describe "StaticPages" do
  before(:each) do
    @page = create(:cmspage)
    create(:currency)
  end

  it "renders static page" do
    visit "/#{@page.page_url}"
    page.should have_content(@page.description)
  end

  it "renders 404" do
    lambda {
      visit '/not_a_page'
    }.should raise_error(ActiveRecord::RecordNotFound)
  end
end