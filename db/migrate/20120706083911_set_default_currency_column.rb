class SetDefaultCurrencyColumn < ActiveRecord::Migration
  def up
  	default = Currency.first
  	default.update_attribute(:default, true) if default
  end

  def down
  end
end
