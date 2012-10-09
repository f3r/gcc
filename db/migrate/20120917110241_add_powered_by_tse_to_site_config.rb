class AddPoweredByTseToSiteConfig < ActiveRecord::Migration
  def change
    add_column :site_configs, :show_powered, :boolean, :default => true
  end
end
