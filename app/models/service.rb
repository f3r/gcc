class Service < ActiveRecord::Base

  before_save :fill_in_address

  if Product.table_exists?
    acts_as :product
    accepts_nested_attributes_for :product
  end

  def self.product_name
    'Service'
  end

  def self.searcher
    Search::Service
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

  def self.price_unit
    SiteConfig.price_unit
  end

  def self.user_reached_limit?(user)
    self.manageable_by(user).count >= 1
  end

  def price_unit
    self.class.price_unit
  end

  def price(a_currency, unit)
    self.product.price(a_currency, unit)
  end

  def primary_photo
    if self.user.avatar?
      self.user.avatar.url(:medium)
    else
      ApplicationHelper.static_asset('missing_userpic_200.jpeg')
    end
  end

  def inquiry_photo
    if self.photos.first
      self.photos.first.photo(:medsmall)
    elsif self.user.avatar?
      self.user.avatar.url(:medium)
    else
      ApplicationHelper.static_asset('missing_userpic_200.jpeg')
    end
  end

  def fill_in_address
    if (address = self.user.address)
      self.address_1 = address.street
      self.zip = address.zip
      self.lat = address.lat
      self.lon = address.lon
    end
    # because this method is a callback, we should return true so validations do not fail
    true
  end

  # Called from Address
  def after_update_address
    self.fill_in_address
    self.save
  end

  # Default radius for the service/show map (2km)
  def radius
    2000
  end

  def display_name
    self.title
  end
end