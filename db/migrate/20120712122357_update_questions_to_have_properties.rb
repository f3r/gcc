class UpdateQuestionsToHaveProperties < ActiveRecord::Migration
  def up
    execute %{
      UPDATE comments, properties,products SET comments.product_id = products.id 
      WHERE comments.place_id = properties.place_id AND products.as_product_type = 'Property' AND properties.id = products.as_product_id;
    }
  end

  def down
  end
end
