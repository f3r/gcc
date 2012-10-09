class Locale < ActiveRecord::Base

  default_scope order: 'position ASC'
  scope :active,    where("active")
  scope :inactive,  where("not active")

  def self.default
    self.first
  end
  
  def activate!
    self.active = true
    self.save
  end

  def deactivate!
    self.active = false
    self.save
  end

end
