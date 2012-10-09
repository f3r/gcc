require 'spec_helper'

describe "CustomWidgetScripts" do
  before(:each) do
    create(:currency)
    create(:city, :name => "Singapore")
    @site_config = SiteConfig.create!(:id => 1, :site_name => 'SquareStays')
  end

  it "renders head_tag script" do
    @site_config.head_tag = "MY HEAD"
    @site_config.save
    visit "/"
    page.should have_content(@site_config.head_tag)
  end

  it "renders script in after body start" do
    @site_config.after_body_tag_start = "AFTER BODY START"
    @site_config.save
    visit "/"
    page.should have_content(@site_config.after_body_tag_start)
  end

  it "renders script in before body end" do
    @site_config.before_body_tag_end = "BEFORE BODY END"
    @site_config.save
    visit "/"
    page.should have_content(@site_config.before_body_tag_end)
  end

end