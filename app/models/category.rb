class Category < ActiveRecord::Base
  def translated_name
    self.name
  end
end
