class CreateAmenities < ActiveRecord::Migration
  def change
    create_table :amenities do |t|
      t.string :name
      t.boolean :searchable
      t.references :amenity_group
      t.timestamps
    end
  end
end
