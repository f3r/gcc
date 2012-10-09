class AddSiteconfigContactFormSelection < ActiveRecord::Migration
  def change
    add_column :site_configs, :show_contact, :boolean, :default => true
  end
end
