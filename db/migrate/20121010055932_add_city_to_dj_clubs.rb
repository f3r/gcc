class AddCityToDjClubs < ActiveRecord::Migration
  def change
    add_column :dj_clubs, :city_id, :integer
    DjClub.reset_column_information
    city = City.find "singapore"
    DjClub.update_all(:city_id => city)
  end
end
