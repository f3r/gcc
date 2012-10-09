class AddColorSchemeToSiteConfig < ActiveRecord::Migration
  def change
    add_column :site_configs, :color_scheme, :string, :default => "default"

  end
end
