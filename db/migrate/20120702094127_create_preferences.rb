class CreatePreferences < ActiveRecord::Migration
  def change
    create_table :preferences do |t|
      t.references :user
      t.references :locale
      t.references :currency
      t.string :size_unit
      t.string :speed_unit
      t.references :city
      t.timestamps
    end
    
    User.all.each do |user|
      Preferences.create :user => user,
                         :locale => Locale.find_by_code(user.pref_language), 
                         :currency => Currency.find_by_currency_code(user.pref_currency), 
                         :size_unit => user.pref_size_unit,
                         :city => City.find_by_id(user.pref_city)
    end
    
    remove_column :users, :pref_language
    remove_column :users, :pref_currency
    remove_column :users, :pref_size_unit
    remove_column :users, :pref_city
  end
end