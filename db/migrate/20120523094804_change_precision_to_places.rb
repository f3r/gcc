class ChangePrecisionToPlaces < ActiveRecord::Migration
  def change
    change_column :places, :lat, :double
    change_column :places, :lon, :double
  end
end