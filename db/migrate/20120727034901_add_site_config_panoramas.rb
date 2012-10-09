class AddSiteConfigPanoramas < ActiveRecord::Migration
  def change
  	add_column :site_configs, :panoramas, :boolean, :default => false
  	add_column :site_configs, :photos, :boolean, :default => true
  end
end
