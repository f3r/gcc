class TranslationVersion < ActiveRecord::Base
  belongs_to :translation
  
  
  def display_name
   created_at.to_formatted_s(:long)
  end
end