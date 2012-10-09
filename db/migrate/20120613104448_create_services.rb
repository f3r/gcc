class CreateServices < ActiveRecord::Migration
  def change
    create_table :services do |t|
      t.timestamps
      t.string  :education_status
      t.string  :last_institute
      t.string  :seeking
      t.integer :language_1
      t.integer :language_2
      t.integer :language_3
    end
  end
end
