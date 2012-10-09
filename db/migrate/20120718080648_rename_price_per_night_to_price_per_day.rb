class RenamePricePerNightToPricePerDay < ActiveRecord::Migration
  def change
  	rename_column :products, :price_per_night, :price_per_day
  	rename_column :products, :price_per_night_usd, :price_per_day_usd
  end
end
