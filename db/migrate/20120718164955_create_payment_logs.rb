class CreatePaymentLogs < ActiveRecord::Migration
  def change
    create_table :payment_logs do |t|
      t.references :payment
      t.string     :state
      t.string     :previous_state
      t.text       :additional_data
      t.timestamp
    end
  end
end
