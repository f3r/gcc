class AddPositionToCustomFields < ActiveRecord::Migration
  def change
    add_column :custom_fields, :position, :integer, :limit => 4, :default => 999999
  end
end
