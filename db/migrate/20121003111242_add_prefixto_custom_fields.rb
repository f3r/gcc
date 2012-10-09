class AddPrefixtoCustomFields < ActiveRecord::Migration
  def change
    add_column :custom_fields, :prefix, :string
  end
end
