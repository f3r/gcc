class AddIpAddressToAppLogger < ActiveRecord::Migration
  def change
    add_column :app_loggers, :ip_address, :string
  end
end
