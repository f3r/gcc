class AddAmenityGroupPromptText < ActiveRecord::Migration
  def change
    add_column :amenity_groups, :prompt_text, :text
  end
end
