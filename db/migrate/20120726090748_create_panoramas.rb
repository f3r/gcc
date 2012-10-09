class CreatePanoramas < ActiveRecord::Migration
  def change
    create_table :panoramas do |t|
      t.references :product
      t.string :photo_file_name
      t.text :xml
      t.string :html_file_name
      t.string :swf_file_name
    end
  end
end
