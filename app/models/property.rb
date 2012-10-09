class Property <  ActiveRecord::Base
  if Product.table_exists?
    acts_as :product
    accepts_nested_attributes_for :product
  end

  validates_presence_of :category_id, :num_bedrooms, :max_guests, :size, :if => :published?
  validates_numericality_of :num_bedrooms, :num_beds, :num_bathrooms, :size, :max_guests, :allow_nil => true
  validate :validate_publishing

  #before_save :update_price_sqf_field

  def self.product_name
    'Place'
  end

  def self.searcher
    Search::Property
  end

  def self.price_unit
    SiteConfig.price_unit
  end

  def self.published
    self.where('products.published' => true)
  end

  def self.unpublished
    self.where('not products.published')
  end

  def self.manageable_by(user)
    self.where('products.user_id' => user.id)
  end

  def self.user_reached_limit?(user)
    false
  end

  def price_unit
    self.class.price_unit
  end

  def price(a_currency, unit = nil)
    self.product.price(a_currency, unit)
  end

  def radius
    0
  end

  protected

  def validate_publishing
    if self.published_changed? && self.published

      unpublish_place = false

      # Place must have 3 pictures
      # Moved to product
      #if self.photos.count < 3
      #  unpublish_place = true
      #  errors.add(:photos, "You need at least 3 pictures")
      #end

      # # Place must have at least 1 amenity
      # if self.amenities_list.blank? || self.amenities_list.count < 1
      #   unpublish_place = true
      #   errors.add(:publish, "143") if published_changed?
      # end

      # general fields
      # if self.size.blank?
      #   unpublish_place = true
      #   errors.add(:publish, "146") if published_changed?
      # end

      # if self.address_1.blank?
      #   unpublish_place = true
      #   errors.add(:publish, "144") if published_changed?
      # end

      # if self.zip.blank?
      #   unpublish_place = true
      #   errors.add(:publish, "145") if published_changed?
      # end

      # Description must have at least 5 words
      # if self.description.blank? or self.description.blank? or self.description.split.size < 5
      #   unpublish_place = true
      #   errors.add(:publish, "124") if published_changed?
      # end

      self.published = false if unpublish_place
    end
  end
end
