class CreateCmspageVersions < ActiveRecord::Migration
  def change
    create_table :cmspage_versions do |t|
      t.references :cmspage
      t.text    "content"
      t.timestamps
    end
    
    #We make this unique ;)
    add_index :cmspage_versions, [:created_at], :unique => true
  end
end
