class AddPolymorphicToInquiry < ActiveRecord::Migration
  def change
    add_column :inquiries, :target_id,   :integer
    add_column :inquiries, :target_type, :string
  end
end
