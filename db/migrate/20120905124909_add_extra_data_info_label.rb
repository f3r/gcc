class AddExtraDataInfoLabel < ActiveRecord::Migration
  def change
    add_column :custom_fields, :more_info_label, :string
  end
end
