class DjClub < ActiveRecord::Base
  has_attached_file :photo1, :styles => { :medium => "600x300>", :thumb => "100x100>" }
  belongs_to :city

  def self.with_points(city = nil)
    result = self
    result = result.where(:city_id => city) if city
    result.order("points desc, id asc")
  end

end