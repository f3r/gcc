# Reverting Index creation from:
#   db/migrate/20120625083240_create_translation_versions.rb
#   db/migrate/20120606111335_create_cmspage_versions.rb

class RemoveIndexesOnCreatedAt < ActiveRecord::Migration
  def up
    remove_index :translation_versions, [:created_at]
    remove_index :cmspage_versions,     [:created_at]
  end

  def down
    add_index :translation_versions, [:created_at], :unique => true
    add_index :cmspage_versions,     [:created_at], :unique => true
  end
end
