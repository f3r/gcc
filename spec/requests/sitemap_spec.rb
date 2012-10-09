require 'spec_helper'

describe "Sitemap" do

  it "renders correct" do
    visit "/sitemap.xml"
    h = Hash.from_xml(page.html)

    h['html']['body']['urlset']['xmlns'].should == 'http://www.sitemaps.org/schemas/sitemap/0.9'
    h['html']['body']['urlset']['url'].length == 1
    #page.should have_content("www.sitemaps.org")
  end

  it "renders the place" do
    p = create(:published_place, :title => "testplace")
    visit "/sitemap.xml"
    h = Hash.from_xml(page.html)
    h['html']['body']['urlset']['url'].length == 2
    h['html']['body']['urlset']['url'][2].should have_content(p.title)
    #page.should have_content("www.sitemaps.org")
  end

end