class CreateMenuSectionPageJoinTable < ActiveRecord::Migration

  def change
    create_table :cmspages_menu_sections, :id => false do |t|
      t.integer :cmspage_id
      t.integer :menu_section_id
      t.timestamps
    end
  end
  
end
