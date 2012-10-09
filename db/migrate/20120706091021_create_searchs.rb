class CreateSearchs < ActiveRecord::Migration
  def change
    create_table :searches do |t|
      t.timestamps
      t.string :type
      t.integer :currency_id
      t.integer :city_id
      t.integer :min_price
      t.integer :max_price
      t.string  :max_lat
      t.string  :min_lat
      t.string  :min_lng
      t.string  :max_lng
      t.integer :guests, :default => 1
      t.datetime :check_in
      t.datetime :check_out
      t.string :sort_by
    end
  end
end
