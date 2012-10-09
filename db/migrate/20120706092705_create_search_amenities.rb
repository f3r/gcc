class CreateSearchAmenities < ActiveRecord::Migration
  def change
    create_table :search_amenities do |t|
      t.references :search
      t.references :amenity
    end
  end
end