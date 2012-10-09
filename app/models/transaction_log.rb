class TransactionLog < ActiveRecord::Base
  belongs_to :transaction
  serialize :additional_data
end
