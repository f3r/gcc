class AddSpeedToGallery < ActiveRecord::Migration
  def change
    add_column :galleries, :transition_speed, :integer, :limit => 4, :default => 1000, :after => :name
    Gallery.reset_column_information
    #This was the default speed for the existing galleries
    Gallery.all.each do |g|
      g.update_attributes!(:transition_speed => 4000)
    end
  end
end
