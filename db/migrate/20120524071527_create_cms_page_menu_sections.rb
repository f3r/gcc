class CreateCmsPageMenuSections < ActiveRecord::Migration
  def change
    create_table :cmspage_menu_sections do |t|
      t.references :cmspage
      t.references :menu_section
      t.timestamps
    end
    add_column :cmspage_menu_sections, :position, "smallint", :default => 0
  end
end
