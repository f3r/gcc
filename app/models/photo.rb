class Photo < ActiveRecord::Base
  belongs_to :product

  before_create :set_initial_position
  after_destroy :update_product_status

  has_attached_file :photo, {
     :styles => {
       :large => {
         :geometry => "602x401>"
         # :watermark_path => lambda {|instance| SiteConfig.photo_watermark.url if SiteConfig.photo_watermark?}
       },
       :medium => "309x200",
       :medsmall => "150x150",
       :small => "70x70",
       :tiny => "40x40"
     },
     :convert_options => {
        :all => "-quality 90"
      },
     :path => "places/:parent_id/photos/:id/:style.:extension",
     :processors => [:rationize, :watermark]
   }

  #validates_presence_of :place_id

  def self.set_positions(photo_ids)
    photo_ids.each_with_index do |photo_id, idx|
      self.find(photo_id).update_attribute(:position, idx + 1)
    end
    true
  end

  def as_json(opts = {})
    photo_hash = {:id => self.id, :name => self.name, :original => self.photo.url}
    [:tiny, :small, :medsmall, :medium, :large].each do |version|
      photo_hash[version] = self.photo.url(version)
    end

    {:photo => photo_hash}
  end

  def remote_photo_url=(url)
    io = open(URI.parse(url))
    def io.original_filename; base_uri.path.split('/').last; end
    self.photo = io.original_filename.blank? ? nil : io
  rescue # catch url errors with validations instead of exceptions (Errno::ENOENT, OpenURI::HTTPError, etc...)
    logger.error "Cannot fetch #{url}"
  end

  def parent_id
    self.place_id
  end

  protected

  def update_product_status
    if self.product && self.product.photos.count < 3
      self.product.update_attribute(:published, false)
    end
  end

  def set_initial_position
    #Place it to the laaaast :)
    self.position = 9999999
  end
end