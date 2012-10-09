class EnableMessageMasking < ActiveRecord::Migration
  def change
    add_column :site_configs, :enable_message_masking, :boolean, :default => true
  end
end
