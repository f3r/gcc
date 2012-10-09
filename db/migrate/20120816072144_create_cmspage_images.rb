class CreateCmspageImages < ActiveRecord::Migration
  def up
    create_table :cmspage_images do |t|
      t.has_attached_file :image
      t.timestamps
    end
  end
  
  def down
    drop_table :cmspage_images
  end
end
