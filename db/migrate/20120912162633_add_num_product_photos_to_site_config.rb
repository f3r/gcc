class AddNumProductPhotosToSiteConfig < ActiveRecord::Migration
  def change
    add_column :site_configs, :listing_photos_count, :Integer, :limit => 4, :default => 0
    SiteConfig.reset_column_information
    config = SiteConfig.first
    config.listing_photos_count = 3 if SiteConfig.product_class.name == "Property"
    config.save
  end
end
