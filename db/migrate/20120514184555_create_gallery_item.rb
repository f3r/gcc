class CreateGalleryItem < ActiveRecord::Migration
  def up
    create_table :gallery_items do |t|
      t.string :link
      t.string :label
      t.has_attached_file :photo
      t.integer :position, :default => 0
      t.boolean  :active, :default => 1
      t.references :gallery, :default => 0
      t.timestamps
   end
  end

  def down
  end
end
