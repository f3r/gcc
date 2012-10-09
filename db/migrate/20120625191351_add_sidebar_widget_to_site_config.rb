class AddSidebarWidgetToSiteConfig < ActiveRecord::Migration
  def change
    add_column :site_configs, :sidebar_widget, :text

  end
end
