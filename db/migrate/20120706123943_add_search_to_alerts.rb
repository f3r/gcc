class AddSearchToAlerts < ActiveRecord::Migration
  def change
    change_table :alerts do |t|
      t.references :search
    end
  end
end
