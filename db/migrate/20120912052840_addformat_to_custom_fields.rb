class AddformatToCustomFields < ActiveRecord::Migration
  def change
    add_column :custom_fields, :date_format, :string, :limit => 20
  end
end
