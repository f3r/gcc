class AddProductCustomValues < ActiveRecord::Migration
  def change
    add_column :products, :custom_values, :text
  end
end
