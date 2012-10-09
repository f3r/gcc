class AddMetaContentToSiteConfig < ActiveRecord::Migration
  def change
    add_column :site_configs, :custom_meta, :text, :null => true
    add_column :site_configs, :meta_description, :text, :null => true
    add_column :site_configs, :meta_keywords, :text, :null => true
  end
end
