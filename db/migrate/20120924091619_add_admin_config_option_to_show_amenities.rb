class AddAdminConfigOptionToShowAmenities < ActiveRecord::Migration
  def change
    add_column :site_configs, :show_all_amenities, :boolean, :default => true
  end
end
