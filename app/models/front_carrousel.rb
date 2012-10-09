class FrontCarrousel < ActiveRecord::Base

  default_scope :order => 'position ASC'

  has_attached_file :photo, {
     :styles => {
       :large => {
         :geometry => "602x401>"
       },
       :tiny => "40x40#"
     },
     :convert_options => {
        :all => "-quality 90"
      },
     :path => "front/photos/:id/:style.:extension",
     :processors => [:rationize]
     # :processors => [:rationize, :watermark]
   }


   #Easy accessor to get the imageurl
   def image_url
     self.photo.url('large')
   end


end