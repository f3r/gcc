class PaymentLog < ActiveRecord::Base
  belongs_to :payment
  serialize :additional_data
end
