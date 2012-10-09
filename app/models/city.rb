class City < ActiveRecord::Base
  extend FriendlyId
  friendly_id :name, use: :slugged

  default_scope order: 'position ASC'
  has_many :products

  before_save :update_cached_complete_name
  after_save :reset_routes_cache

  scope :active,    where("active")
  scope :inactive,  where("not active")

  attr_accessible :name, :lat, :lon, :state, :country, :country_code, :cached_complete_name, :active, :position, :slug, :geoname_id

  def self.active_and_have_a_listing
    self.active.joins(:products).uniq.all
  end

  def self.default
    self.first
  end

  def self.routes_regexp
  	# Matches the name of a city
  	if self.table_exists? && self.any?
  	  Regexp.new(self.all.collect{|city| city.slug if city.respond_to?(:slug)}.join('|'))
  	else
  	  # default
  	  /singapore/
  	end
  end

  def self.geonames_search(name, country_code = nil)
    criteria = Geonames::ToponymSearchCriteria.new
    criteria.name = name unless name.blank?
    criteria.country_code = country_code unless country_code.blank?
    criteria.max_rows = '10'
    #criteria.feature_codes = ['PPL', 'PPL?']
    Geonames::WebService.search(criteria).toponyms.collect{|t| self.new_from_geonames(t)}
  end

  # def self.new_from_geoname_id(g_id)

  # end

  def self.new_from_geonames(toponym)
    City.new(
      :name => toponym.name,
      :country => toponym.country_name,
      :country_code => toponym.country_code,
      :geoname_id => toponym.geoname_id,
      :lat => toponym.latitude,
      :lon => toponym.longitude,
      :active => true
    )
  end

  def activate!
    self.active = true
    self.save
  end

  def deactivate!
    self.active = false
    self.save
  end

  def complete_name
    "#{self.name}, #{self.state}, #{self.country}".gsub(", ,",",")
  end

  def update_cached
    self.update_attribute(:cached_complete_name, self.complete_name)
  end

  def code
    self.slug.to_sym
  end

  def country_name
    self.country
  end

  def I18n_code
    "cities.#{self.name.parameterize('_')}"
  end

  def geocoded?
    self.lat.present? && self.lon.present?
  end

  private

  def update_cached_complete_name
    unless self.cached_complete_name == self.complete_name
      self.update_cached
    end
  end

  def reset_routes_cache
    HeyPalFrontEnd::Application.reload_routes!
  end

  # def name
  #   I18n.t(self.code)
  # end
  #
  # def country_name
  #   I18n.t(self.country_code)
  # end

end