class AddFixedRadius < ActiveRecord::Migration
  def change
    add_column :site_configs, :fixed_radius, :integer
  end
end
