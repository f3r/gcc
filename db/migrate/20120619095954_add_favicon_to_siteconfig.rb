class AddFaviconToSiteconfig < ActiveRecord::Migration
  def change
    add_column :site_configs, :fav_icon_file_name, :string
  end
end
