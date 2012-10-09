class AlterUnitPreferences < ActiveRecord::Migration
  def change
    Preferences.all.each do |preference|
      if !preference.size_unit.nil?
        if preference.size_unit == "sqm"
          preference.size_unit = 0
        end
        if preference.size_unit == "sqf"
          preference.size_unit = 1
        end
        
        if preference.speed_unit == "kmh"
          preference.speed_unit = 0
        end
        if preference.speed_unit == "mph"
          preference.speed_unit = 1
        end
        
        preference.save
      end
    end
    
    rename_column :preferences, :size_unit, :size_unit_id
    rename_column :preferences, :speed_unit, :speed_unit_id
     
    change_column :preferences, :size_unit_id, :integer
    change_column :preferences, :speed_unit_id, :integer
    
  end
end
