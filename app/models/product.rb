class Product < ActiveRecord::Base
  acts_as_superclass

  belongs_to :user
  belongs_to :city
  belongs_to :currency
  belongs_to :category
  belongs_to :city
  has_many   :photos,            :dependent => :destroy, :order => :position
  has_many   :panoramas,         :dependent => :destroy
  has_many   :favorites,         :dependent => :destroy, :as => :favorable
  has_many   :product_amenities, :dependent => :destroy
  has_many   :reviews,           :dependent => :destroy
  has_many   :q_and_a,           :dependent => :destroy, :class_name => 'Comment'
  has_many   :amenities,         :through => :product_amenities

  serialize :custom_values

  attr_accessor :terms
  attr_accessible :points

  validates_presence_of :currency, :city, :title
#  validates_presence_of :price_field, :if => :published?

  validates_numericality_of :price_per_day, :price_per_hour, :price_per_week, :price_per_month, :price_sale, :allow_nil => true

  validate :validate_photo_count

  before_save :geocode, :convert_prices_to_usd, :index_amenities

  geocoded_by :full_address, :latitude  => :lat, :longitude => :lon

  def self.published
    self.where('products.published' => true)
  end

  def self.unpublished
    self.where('not products.published')
  end

  def self.manageable_by(user)
    self.where('products.user_id' => user.id)
  end

  def self.price_unit
    SiteConfig.price_unit
  end

  def self.min_photo_count
    return 0 unless SiteConfig.listing_photos_count.present?
    SiteConfig.listing_photos_count
  end

  def primary_photo
    if self.photos.first
      self.photos.first.photo(:medsmall)
    else
      'http://placehold.it/150x100'
    end
  end

  # Photo representation for the inquiry
  def inquiry_photo
    if self.photos.first
      self.photos.first.photo(:medsmall)
    end
  end

  def publish!
    self.specific.published = true
    self.specific.save
  end

  def unpublish!
    # Without validations
    self.update_attribute(:published, false)
  end

  def publish_check!
    self.specific.published = true
    self.specific.save
  end

  def price(a_currency = nil, unit = nil)
    unit ||= self.class.price_unit
    a_currency ||= Currency.default

    # If we are asked in the original currency of the place
    if self.currency == a_currency
      amount = self.send("price_#{unit}")
    else
      # If we are asked in the 'special' USD (precalculated with before_save callback)
      if a_currency.usd?
        amount = self.send("price_#{unit}_usd")
        amount = amount / 100 if amount
      else
        # Must convert between USD and a_currency
        amount_usd = self.send("price_#{unit}_usd")
        amount = a_currency.from_usd(amount_usd/100.0) if amount_usd
      end
    end
    [a_currency.symbol, amount]
  end

  def price_field
    unit = self.class.price_unit
    self.send("price_#{unit}")
  end

  def money_price(unit = nil, currency = nil)
    unit ||= self.class.price_unit
    currency ||= self.currency

    amount = self.send("price_#{unit}")
    if amount
      amount.to_money(currency.currency_code)
    end
  end

  def full_address
    [address_1, address_2, city.name, city.state, city.country].compact.join(', ')
  end

  def geocoded?
    self.lat.present? && self.lon.present?
  end

  def review_avg
    self.reviews.average(:score).to_i
  end

  def has_review?
    self.reviews.any?
  end

  def has_any_paid_transactions?(user)
    Transaction.joins(:inquiry).where('state = ?', :paid).where('transactions.user_id = ?', user).where('inquiries.product_id = ?', self.id).count > 0
  end

  def convert_prices_to_usd
    return true unless currency
    [:per_hour, :per_day, :per_week, :per_month, :sale].each do |unit|
      field = "price_#{unit}"
      field_usd = "#{field}_usd"
      if self.changed.include?(field)
        price_value = read_attribute(field)
        if price_value
          price_usd = self.currency.to_usd(price_value) * 100.0
          write_attribute(field_usd, price_usd)
        end
      end
    end
    true
  end

  def wizard_step
    self.completed_steps
  end

  def wizard_step=(step)
    step_number = step.to_i
    if step_number > self.completed_steps
      self.completed_steps = step_number
    end
  end

  def custom_fields=(values)
    self.custom_values ||= {}
    self.custom_values.merge!(values)
  end

  def custom_fields
    self.custom_values || {}
  end

protected

  def after_update_address
    return true
  end

  def index_amenities
    ids = self.amenity_ids
    if ids
      self.amenities_search = ids.sort.collect{|id| "<#{id}>"}.join(',')
    else
      self.amenities_search = nil
    end
  end

  def validate_photo_count
    if self.published_changed? && self.published && (self.photos.count < self.class.min_photo_count)
      errors.add(:photos, I18n.t('products.messages.listing_photos_count_error', :photo_count => SiteConfig.listing_photos_count))
      self.published = false
    end
  end
end
