class AdminUser < ActiveRecord::Base
  self.table_name= :users

  include User::Roles

  default_scope where(["role = ? or role = ?", "admin", "superadmin"])

  # Include default devise modules. Others available are:
  # :token_authenticatable, :encryptable, :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable,
         :recoverable, :rememberable, :trackable, :validatable

  # Setup accessible (or protected) attributes for your model
  attr_accessible :email, :password, :password_confirmation, :remember_me

  def role_symbols
    [:admin]
  end

  def super_admin?
    self.role == 'superadmin'
  end

  def agent?
    false
  end

  def user
    User.find(self.id)
  end
end
