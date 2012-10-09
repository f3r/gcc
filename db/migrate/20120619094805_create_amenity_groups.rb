class CreateAmenityGroups < ActiveRecord::Migration
  def change
    create_table :amenity_groups do |t|
      t.string :name
      t.timestamps
    end
  end
end
