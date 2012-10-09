class AddLatLonToAddress < ActiveRecord::Migration
  def change
    add_column :addresses, :lat, :decimal, {:precision => 15, :scale => 12}
    add_column :addresses, :lon, :decimal, {:precision => 15, :scale => 12}
  end
end