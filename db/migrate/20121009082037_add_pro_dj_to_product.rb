class AddProDjToProduct < ActiveRecord::Migration
  def change
     add_column :products, :pro_dj, :boolean , :default => true
  end
end
