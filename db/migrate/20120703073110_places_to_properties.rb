class PlacesToProperties < ActiveRecord::Migration
  def up
    amenity_fields = Place.columns.collect(&:name).grep(/amenities/)
    # amenity_map = {}
    # amenity_fields.each do ||
    # end
    review_fields = Place.columns.collect(&:name).grep(/reviews/)
    Place.find_each do |place|
      attr = place.attributes.except(*amenity_fields)
      attr = attr.except(*review_fields)
      attr = attr.except('city_name', 'country_name', 'state_name', 'country_code')

      pt_id = attr.delete('place_type_id')
      currency_str = attr.delete('currency')
      attr['price_per_day'] = attr.delete('price_per_night')
      attr['price_per_day_usd'] = attr.delete('price_per_night_usd')
      attr.delete('photos_old')

      prop = Property.new(attr)
      prop.category = Category.find_by_name!(place.place_type.name)
      prop.currency = place.currency
      prop.place_id = place.id

      unless prop.save
        puts "WARNING: Couldn't save prop #{place.id}: #{prop.errors.full_messages}"
      end
    end

    Photo.find_each do |photo|
      property = Property.find_by_place_id!(photo.place_id)
      photo.product = property.product
      photo.save!
    end
  end

  def down
  end
end

class ::Product
  def self.price_unit
    :per_month
  end
end