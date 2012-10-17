class ClubPhoto < ActiveRecord::Base
  has_attached_file :photo, :styles => { :medium => "600x300>", :thumb => "100x100>" }
  belongs_to :dj_club
end