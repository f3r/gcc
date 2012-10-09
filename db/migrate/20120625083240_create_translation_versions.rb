class CreateTranslationVersions < ActiveRecord::Migration
  def change
    create_table :translation_versions do |t|
      t.references :translation
      t.text "value"
      t.timestamps
    end
    #We make this unique ;)
    add_index :translation_versions, [:created_at], :unique => true
  end
end
