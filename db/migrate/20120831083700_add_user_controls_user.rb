class AddUserControlsUser < ActiveRecord::Migration
  def change
    add_column :users, :controls_user_id, :integer
  end
end
