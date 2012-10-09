class Gallery < ActiveRecord::Base
  validates_presence_of [:name], :message => "Name can't be empty"
  validates_format_of :name, :with => /\A(^[a-z]{1}[a-z0-9_]+)\Z/, :message => "Invalid name"
  validates_uniqueness_of :name, :message => "Name should be unique"
  has_many :gallery_items, :dependent => :destroy

  before_save :no_nil_to_transistion_speed

  private
  def no_nil_to_transistion_speed
    self.transition_speed = 0 if self.transition_speed.nil?
  end
end
