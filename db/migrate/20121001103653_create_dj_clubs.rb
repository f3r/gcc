class CreateDjClubs < ActiveRecord::Migration
  def change
    create_table :dj_clubs do |t|
      t.string  :name
      t.string  :email
      t.text    :description
      t.text    :location
      t.string  :website
      t.string  :phone
      t.integer :points
      t.boolean :active , :default => true
      t.timestamps
    end
  end

end
