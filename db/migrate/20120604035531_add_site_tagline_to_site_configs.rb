class AddSiteTaglineToSiteConfigs < ActiveRecord::Migration
  def change
    add_column :site_configs, :site_tagline, :string
  end
end
