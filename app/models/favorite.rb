class Favorite < ActiveRecord::Base
  # TODO: No need for this to be polymorphic anymore, replace with belongs_to :product
  belongs_to :favorable,   :polymorphic => true
  belongs_to :user

  validates :user_id,        :presence => true
  validates :favorable_id,   :presence => true, :uniqueness => {:scope => [:user_id, :favorable_type]}
  validates :favorable_type, :presence => true

  def self.for_user(user, klass)
    klass.joins(:product => :favorites).where('favorites.user_id' => user.id)
  end

  def self.is_favorited?(obj, user)
    obj.favorites.where(:user_id => user.id).exists?
  end
end