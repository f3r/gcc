class CmspageVersion < ActiveRecord::Base
  belongs_to :page
  
  include ActionView::Helpers::DateHelper
  
  def display_name
   created_at.to_formatted_s(:long)
  end
end