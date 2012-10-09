class ChangeLatLonPrecisionForProducts < ActiveRecord::Migration
  def change
    change_column :products, :lat, :decimal, {:precision => 15, :scale => 12}
    change_column :products, :lon, :decimal, {:precision => 15, :scale => 12}
  end
end
