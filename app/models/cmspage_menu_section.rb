class CmspageMenuSection < ActiveRecord::Base
  belongs_to :cmspage
  belongs_to :menu_section
end