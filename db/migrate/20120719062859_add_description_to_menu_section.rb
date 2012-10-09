class AddDescriptionToMenuSection < ActiveRecord::Migration
  def change
    add_column :menu_sections, :description, :text
  end
end
