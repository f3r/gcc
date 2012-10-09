class Amenity < ActiveRecord::Base
  belongs_to :amenity_group

  attr_accessible :name, :searchable, :amenity_group_id

  def self.searchable
    self.where(:searchable => true)
  end
end
