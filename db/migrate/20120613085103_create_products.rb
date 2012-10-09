class CreateProducts < ActiveRecord::Migration
  def change
    create_table :products, :as_relation_superclass => true do |t|
      t.references :user
      t.boolean    :published
      t.string     :title
      t.text       :description
      t.references :city
      t.string     :address_1, :address_2, :zip
      t.float      :lat, :lon
      t.integer    :radius
      t.references :currency
      t.integer    :price_per_hour, :price_per_hour_usd
      t.integer    :price_per_week, :price_per_week_usd
      t.integer    :price_per_month, :price_per_month_usd
      t.integer    :price_sale, :price_sale_usd

      t.timestamps
    end
  end
end