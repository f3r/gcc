class AddPhotoWatermarkToSiteConfig < ActiveRecord::Migration
  def up
    change_table :site_configs do |t|
      t.has_attached_file :photo_watermark
    end
  end
  
  def down
    drop_attached_file :site_configs, :photo_watermark
  end
end
