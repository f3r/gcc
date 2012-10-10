class DjPointHistory < ActiveRecord::Base
  belongs_to :product
  validates_presence_of :product
end