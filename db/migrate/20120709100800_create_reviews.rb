class CreateReviews < ActiveRecord::Migration
  def change
    create_table :reviews do |t|
      t.references :user
      t.references :product
      t.integer :score
      t.text :body

      t.timestamps
    end
    add_index :reviews, :user_id
    add_index :reviews, :product_id
  end
end
