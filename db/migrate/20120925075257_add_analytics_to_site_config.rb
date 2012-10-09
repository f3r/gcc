class AddAnalyticsToSiteConfig < ActiveRecord::Migration
  def change
    add_column :site_configs, :gae_tracking_code_tse, :string
  end
end
