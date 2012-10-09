class AddMetaKeywordsToCmspages < ActiveRecord::Migration
  def change
      add_column :cmspages, :meta_keywords, :text ,:null => true
  end
end
