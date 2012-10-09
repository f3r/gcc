class AddSearchViewTypeToSiteConfig < ActiveRecord::Migration
  def change
    add_column :site_configs, :search_default_view_type_cd, :integer, :default => 0
  end
end
