class AppLogger < ActiveRecord::Base
  serialize :params, JSON

  scope :all, :default => true
  scope :guest,  where("user_role = \"guest\"")
  scope :agent,  where("user_role = \"agent\"")
  scope :admin,  where("user_role = \"admin\"")
  scope :superadmin,  where("user_role = \"superadmin\"")

end