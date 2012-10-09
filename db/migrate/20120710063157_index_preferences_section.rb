class IndexPreferencesSection < ActiveRecord::Migration
  def change
     create_table :preference_sections do |t|
      t.string :name
      t.string :code
      t.integer :position
      t.boolean :active, :default => false
      t.timestamps
    end
    
    PreferenceSection.create({:name => "Language", :code => "language_pref", :position => 1, :active => true})
    PreferenceSection.create({:name => "Currency", :code => "currency_pref", :position => 2, :active => true})
    PreferenceSection.create({:name => "Size Unit", :code => "size_unit_pref", :position => 3, :active => true})
    PreferenceSection.create({:name => "Speed Unit", :code => "speed_unit_pref", :position => 4, :active => true})
  end
end
