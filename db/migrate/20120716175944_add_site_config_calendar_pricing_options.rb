class AddSiteConfigCalendarPricingOptions < ActiveRecord::Migration
  def change
    add_column :site_configs, :calendar,                :boolean, :default => true
    add_column :site_configs, :enable_price_per_hour,   :boolean
    add_column :site_configs, :enable_price_per_day,    :boolean
    add_column :site_configs, :enable_price_per_week,   :boolean
    add_column :site_configs, :enable_price_per_month,  :boolean
    add_column :site_configs, :enable_price_sale,       :boolean
  end
end
