class AddPositionToMenuSectionPageJoinTable < ActiveRecord::Migration
  def change
    add_column :cmspages_menu_sections, :position, "smallint", :default => 0
  end
end
