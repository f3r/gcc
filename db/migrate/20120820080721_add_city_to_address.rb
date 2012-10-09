class AddCityToAddress < ActiveRecord::Migration
  class Address < ActiveRecord::Base
  end
    
  def change
    rename_column :addresses, :city, :city_old
    add_column :addresses, :city_id, :integer
    Address.reset_column_information
    Address.all.each do |address|
      begin
        city = City.find address.city_old.to_s
        say "Found #{address.city_old}"
        address.update_attributes!(:city_id => city.id) if city
      rescue => detail
        say "Unable to find city #{address.city_old}"
      end
    end
  end
end