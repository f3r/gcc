class CreateProperties < ActiveRecord::Migration
  def change
    create_table :properties do |t|
      t.timestamps
      t.integer  :num_bedrooms
      t.integer  :num_beds
      t.integer  :num_bathrooms
      t.float    :size
      t.integer  :max_guests

      t.text     :directions

      t.integer  :price_final_cleanup,                     :default => 0
      t.integer  :price_security_deposit,                  :default => 0
      t.integer  :price_final_cleanup_usd
      t.integer  :price_security_deposit_usd

      t.string   :check_in_after
      t.string   :check_out_before
      t.integer  :minimum_stay,                            :default => 0
      t.integer  :maximum_stay,                            :default => 0
      t.text     :house_rules
      t.integer  :cancellation_policy,                     :default => 1

      t.float    :size_sqm
      t.float    :size_sqf
      t.string   :size_unit

      t.float    :price_sqf_usd
      t.string   :stay_unit
      t.integer  :place_id
    end
  end
end
