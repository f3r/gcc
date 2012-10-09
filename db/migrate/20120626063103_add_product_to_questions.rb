class AddProductToQuestions < ActiveRecord::Migration
  def change
    add_column :comments, :product_id, :integer
  end
end
