require 'spec_helper'

describe "Places Management" do
  before(:each) do
    @agent    = create(:agent)
    @currency = create(:currency)
    @city     = create(:city, :name => "Singapore")
    @place    = create(:published_place, :user => @agent)
    SiteConfig.stub(:product_class).and_return(Property)
  end

  it 'shows places for a city' do
    login_as @agent
    visit '/listings'
    page.should have_content(@place.title)
  end
end