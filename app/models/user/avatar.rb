class User
  module Avatar
    extend ActiveSupport::Concern

    included do
      has_attached_file :original_avatar,
        :path => "/original_avatars/:id/:style.:extension",
        :styles => {
          :croppable => '500x350>'
        }

      has_attached_file :avatar,
        :styles => {
          :thumb  => "100x100#",
          :medium => "300x300#",
          :large  => "600x600>"
        },
        :path => "/avatars/:id/:style.:extension",
        :default_url => "none",
        :convert_options => {
          :large => "-quality 80",
          :medium => "-quality 80",
          :thumb => "-quality 80" },
        :processors => [:cropper]

      attr_accessor :delete_avatar, :crop_x, :crop_y, :crop_w, :crop_h, :image_h, :image_w
      attr_accessible :crop_x, :crop_y, :crop_w, :crop_h, :image_h, :image_w

      def cropping?
        !crop_x.blank? && !crop_y.blank? && !crop_w.blank? && !crop_h.blank?
      end

    end
  end
end