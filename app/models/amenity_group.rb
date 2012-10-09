class AmenityGroup < ActiveRecord::Base
  has_many :amenities

  attr_accessible :name,:prompt_text
  
  #For active admin
  def display_name
    self.name
  end
end
