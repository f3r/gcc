class CreateContactRequestTableDetails < ActiveRecord::Migration
 def change
    create_table :contact_requests do |t|
      t.string :name
      t.string :email
      t.text :message
      t.boolean :active , :default => true

      t.timestamps
    end
  end
end
