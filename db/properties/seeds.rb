["Apartment", "House", "Villa", "Room", "Other space"].each do |cat_name|
  unless Category.exists?(name: cat_name)
    Category.create!(name: cat_name)
  end
end

g = AmenityGroup.create!(name: 'Place & Building facilities')
g.amenities.create!(name: 'Kitchen')
g.amenities.create!(name: 'Hot Water')
g.amenities.create!(name: 'Elevator')
g.amenities.create!(name: 'Parking Space')
g.amenities.create!(name: 'Heating')
g.amenities.create!(name: 'Handicap accessible')
g.amenities.create!(name: 'Doorman')
g.amenities.create!(name: 'Air Conditioning')
g.amenities.create!(name: 'Buzzer/Intercom')

g = AmenityGroup.create!(name: 'Conveniences')
g.amenities.create!(name: 'Internet')
g.amenities.create!(name: 'TV')
g.amenities.create!(name: 'Dryer')
g.amenities.create!(name: 'Wifi')
g.amenities.create!(name: 'Cable TV')
g.amenities.create!(name: 'Washer')

g = AmenityGroup.create!(name: 'Sports & Recreation')
g.amenities.create!(name: 'Gym')
g.amenities.create!(name: 'Jacuzzi')
g.amenities.create!(name: 'Hot Tub')
g.amenities.create!(name: 'Tennis')
g.amenities.create!(name: "Pool")

g = AmenityGroup.create!(name: 'Miscellaneous')
g.amenities.create!(name: 'Pets Allowed')
g.amenities.create!(name: 'Breakfast')
g.amenities.create!(name: 'Smoking Allowed')
g.amenities.create!(name: 'Suitable for Events')
g.amenities.create!(name: "Family Friendly")
