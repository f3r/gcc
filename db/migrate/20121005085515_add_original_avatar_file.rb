class AddOriginalAvatarFile < ActiveRecord::Migration
  def change
    add_column :users, :original_avatar_file_name, :string
  end
end
