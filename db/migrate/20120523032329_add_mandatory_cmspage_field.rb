class AddMandatoryCmspageField < ActiveRecord::Migration
  def change
    add_column :cmspages, :mandatory, :boolean, :default => false
  end
end
