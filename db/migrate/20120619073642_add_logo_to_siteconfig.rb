class AddLogoToSiteconfig < ActiveRecord::Migration
  def change
    add_column :site_configs, :logo_file_name, :string
  end
end
