class Address < ActiveRecord::Base
  belongs_to :user
  belongs_to :city

  geocoded_by :bussiness_address, :latitude  => :lat, :longitude => :lon

  before_save :geocode

  validates_presence_of :city
  validates_presence_of :street
  validates_presence_of :zip

  attr_accessible :street, :city_id, :zip, :user_id

  def bussiness_address
    [street, city.name, city.state, zip, city.country].compact.join(', ')
  end

end