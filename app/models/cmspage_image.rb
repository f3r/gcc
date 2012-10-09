class CmspageImage < ActiveRecord::Base
  has_attached_file :image, {
    :styles => {
      :thumb  => "100x100#"
    },
    :path => "cmspage/:id/:style/:filename"
  }
end