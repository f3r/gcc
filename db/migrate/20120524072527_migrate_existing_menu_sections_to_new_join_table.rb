class MigrateExistingMenuSectionsToNewJoinTable < ActiveRecord::Migration
  def up
    execute <<-SQL
      INSERT INTO cmspage_menu_sections(cmspage_id,menu_section_id) 
      SELECT cmspage_id,menu_section_id FROM cmspages_menu_sections
    SQL
  end

  def down
      execute <<-SQL
        DELETE FROM cmspage_menu_sections
    SQL

  end
end
