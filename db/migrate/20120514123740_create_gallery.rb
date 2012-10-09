class CreateGallery < ActiveRecord::Migration
  def up
    create_table :galleries do |t|
      t.string :name, :null => false
      t.timestamps
    end
  end

  def down
  end
end
