class Review < ActiveRecord::Base
  belongs_to :user
  belongs_to :product

  validates_presence_of :user, :product, :score
  validates_uniqueness_of :user_id, :scope => :product_id
end
