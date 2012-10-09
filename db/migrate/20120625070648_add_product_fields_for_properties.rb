class AddProductFieldsForProperties < ActiveRecord::Migration
  def change
    add_column :products, :category_id, :integer
    add_column :products, :price_per_night, :integer
    add_column :products, :price_per_night_usd, :integer
  end
end
