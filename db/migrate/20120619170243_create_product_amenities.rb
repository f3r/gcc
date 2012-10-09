class CreateProductAmenities < ActiveRecord::Migration
  def change
    create_table :product_amenities do |t|
      t.references :product
      t.references :amenity
    end
  end
end
