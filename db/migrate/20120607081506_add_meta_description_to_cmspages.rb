class AddMetaDescriptionToCmspages < ActiveRecord::Migration
  def change
       add_column :cmspages, :meta_description,:text ,:null => true
  end
end
