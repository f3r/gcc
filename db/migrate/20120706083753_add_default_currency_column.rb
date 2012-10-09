class AddDefaultCurrencyColumn < ActiveRecord::Migration
  def change
  	add_column :currencies, :default, :boolean, :default => false
  end
end
