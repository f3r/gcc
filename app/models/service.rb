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
  
  def profile_completeness
    
    #current calculation policy
    
    #total = 100
    #has photos, 25+
    #has amenities, 25+
    #has any of the social_urls, 20+
    #has more than 3 social_urls, 10+ (as bonus points)
    #has biography, 20+
    
    profile_completeness_score = 0
    profile_completeness_status = Array.new
    
    # Adding points, if DJ has photos
    if self.photos.present?
      if self.photos.count == 1
        profile_completeness_score += 15
        profile_completeness_status << [10,'Add more photos', "photos"]
      else
        profile_completeness_score += 25
      end
    else
      profile_completeness_status << [25,'Add photos', "photos"]  
    end
    
    # Adding points, if DJ has genres
    if  self.amenities.present?
     profile_completeness_score += 25
    else
     profile_completeness_status << [25,'Add Amenities', "traits"]   
    end
    
    social_points = 0
    
    self.custom_fields.each_pair do |key, value|
      unless ["label", "bio", "website", "sex"].include?(key)
        social_points += 1 if value.present? 
      end
    end
   
    # Adding points, if DJ has any social urls
    if social_points > 0   
      profile_completeness_score += 20
    else
      profile_completeness_status << [20, 'Add Social Urls', "custom_fields"]   
    end
    
    # Adding bonus points, if DJ has more than 3 social urls
    if social_points > 3
      profile_completeness_score += 10
    else
      profile_completeness_status << [10, 'Add more Social Urls', "custom_fields"]   
    end
    
    # Adding points, if DJ added his biography
    if self.custom_fields["bio"].present?
      profile_completeness_score += 20
    else
      profile_completeness_status << [20, 'Add Biography', "custom_fields"]   
    end
    return profile_completeness_score, profile_completeness_status
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