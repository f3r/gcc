require 'spec_helper'

describe SiteConfig do
  context "Singleton Behavior" do
    before(:each) do
      @site_config = SiteConfig.create!(:id => 1, :site_name => 'SquareStays')
    end

    it "returns the site_name" do
      SiteConfig.stub(:instance).and_return(@site_config)
      SiteConfig.site_name.should == @site_config.site_name
    end

    it "resets the cache when saving" do
      SiteConfig.site_name.should == @site_config.site_name
      @site_config.site_name = 'SquareNew'
      @site_config.save!

      SiteConfig.site_name.should == 'SquareNew'
    end

    it "overrides favicon with favicon.ico name regardless of the original name" do
      fav_icon = File.open("#{Rails.root}/db/rake_seed_images/favicon.png")
      @site_config.fav_icon = fav_icon
      @site_config.save!
      SiteConfig.fav_icon.path.should =~ /favicon.ico$/
    end

    it "overrides logo with logo.png name regardless of the original name" do
      logo = File.open("#{Rails.root}/db/rake_seed_images/a_logo.png")
      @site_config.logo = logo
      @site_config.save!
      SiteConfig.logo.path.should =~ /\/logo.png$/
    end
  end
end