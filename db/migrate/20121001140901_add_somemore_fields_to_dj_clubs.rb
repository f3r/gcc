class AddSomemoreFieldsToDjClubs < ActiveRecord::Migration
  def up
    add_column :dj_clubs, :address, :text
    add_attachment :dj_clubs, :photo1
  end

  def down
    remove_column :dj_clubs, :address
    remove_attachment :dj_clubs, :photo1
  end
end
