class CitiesAddGeonameIdColumn < ActiveRecord::Migration
  def change
  	add_column :cities, :geoname_id, :integer
  end
end
