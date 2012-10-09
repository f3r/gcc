class AddTypeColumnToCmspages < ActiveRecord::Migration
  def change
    add_column :cmspages, :type, :string, :null => false, :default => "Page"
  end
end
