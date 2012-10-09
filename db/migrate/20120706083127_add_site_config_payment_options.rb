class AddSiteConfigPaymentOptions < ActiveRecord::Migration
  def change
    add_column :site_configs, :charge_total, :boolean, :default => false
    add_column :site_configs, :fee_amount, :integer, :default => 300
    add_column :site_configs, :fee_is_fixed, :boolean, :default => true
  end
end
