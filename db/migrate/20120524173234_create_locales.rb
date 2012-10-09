# encoding: utf-8
class CreateLocales < ActiveRecord::Migration
  def change
    create_table :locales do |t|
      t.string :code
      t.string :name
      t.string :name_native
      t.integer :position
      t.boolean :active, :default => false
    end
    add_index :locales, [:code], :unique => true
    
    Locale.create({:code => "en", :name => "English", :name_native => "English", :position => 1, :active => true})
    Locale.create({:code => "es", :name => "Spanish", :name_native => "Español", :position => 2, :active => true})
  end
end