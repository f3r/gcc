class EnumForServiceLanguages < ActiveRecord::Migration
  def up
    rename_column :services, :language_1, :language_1_cd
    rename_column :services, :language_2, :language_2_cd
    rename_column :services, :language_3, :language_3_cd
  end

  def down
  	rename_column :services, :language_1_cd, :language_1
  	rename_column :services, :language_2_cd, :language_2
  	rename_column :services, :language_3_cd, :language_3
  end
end
