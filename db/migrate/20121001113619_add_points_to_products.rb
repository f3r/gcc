class AddPointsToProducts < ActiveRecord::Migration
  def change
    add_column :products, :points, :integer
  end
end
