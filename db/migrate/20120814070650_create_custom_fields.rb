class CreateCustomFields < ActiveRecord::Migration
  def change
    create_table :custom_fields do |t|
      t.string :name, :label, :hint
      t.integer :type_cd
      t.text :values
      t.string :validations
      t.boolean :required

      t.timestamps
    end
  end
end
