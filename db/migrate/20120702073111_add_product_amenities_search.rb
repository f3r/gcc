class AddProductAmenitiesSearch < ActiveRecord::Migration
  def up
  	add_column :products, :amenities_search, :string, :length => 500
  	Product.find_each(&:save)
  end

  def down
  	remove_column :products, :amenities_search
  end
end
