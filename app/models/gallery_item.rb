class GalleryItem < ActiveRecord::Base

  belongs_to :gallery

  scope :active, where(:active => true).order("position ASC")

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
     # :processors => [:rationize, :watermark]
     :processors => [:rationize]

   }


   #Easy accessor to get the imageurl
   def image_url
     self.photo.url('large')
   end


end