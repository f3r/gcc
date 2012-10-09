class AddCustomWidgetsConfigsToSiteConfig < ActiveRecord::Migration
  def change
    add_column :site_configs, :head_tag, :text
    add_column :site_configs, :after_body_tag_start, :text
    add_column :site_configs, :before_body_tag_end, :text
  end
end
