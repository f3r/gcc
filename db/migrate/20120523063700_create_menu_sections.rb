class CreateMenuSections < ActiveRecord::Migration
  def change
    create_table :menu_sections do |t|
      t.string :name, :null => false
      t.string :display_name, :null => false
      t.timestamps
    end
      add_index :menu_sections, :name, unique: true
  end
end
