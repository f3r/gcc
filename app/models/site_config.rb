class SiteConfig < ActiveRecord::Base

  after_save :reset_cache, :refresh_devise_omniauth

  has_attached_file :fav_icon,        :path => "static/favicon.ico"
  has_attached_file :logo,            :path => "static/logo.png"
  # has_attached_file :photo_watermark, :path => "watermarks/photowatermark.jpg"

  as_enum :search_default_view_type, [:list, :grid]

  def self.instance
    @instance = @instance || SiteConfig.first || SiteConfig.new
  end

  def self.mail_sysadmins
    %w(jeremy@thesharingengine.com fer@thesharingengine.com nico@thesharingengine.com).join(', ')
  end

  def self.method_missing(name, *args)
    if self.running_migrations?
      return self.default_to_constant(name)
    end
    if self.instance.respond_to?(name.to_s)
      val = self.instance.send(name.to_s) if self.instance

      if !val.nil?
        val
      else
        # Backward compatibility with config constants
        self.default_to_constant(name)
      end
    else
      super
    end
  end

  def self.running_migrations?
    @migrating ||= !self.table_exists?
  end

  def self.default_to_constant(name)
    name.to_s.upcase.safe_constantize
  end

  # get a list of color_schemes the directory, get name from the first line
  def self.color_schemes
    color_schemes = []
    basedir = Rails.root + "app/assets/stylesheets/color_schemes/"
    css_files = Dir.glob(basedir + '*')
    css_files.each do |directory|
      file = directory + "/index.less"
      description = File.open(file) {|f| f.readline}.gsub("/*", "").gsub("*/", "").strip!
      name = directory.gsub(basedir.to_s,"")
      color_schemes << [description, name] if description && name
    end
    return color_schemes
  end

  def self.product_class
    PRODUCT_CLASS_NAME.constantize
  end

  def self.product_plural
    begin
      I18n.t!('product_name_plural')
    rescue I18n::MissingTranslationData
      self.product_name.pluralize
    end
  end

  def self.product_name
    begin
      I18n.t!('product_name')
    rescue I18n::MissingTranslationData
      self.product_class.product_name
    end
  end

  def site_name
    return read_attribute(:site_name) if read_attribute(:site_name).present?
    I18n.t!("default_site_title")
  end

  def site_tagline
    return read_attribute(:site_tagline) if read_attribute(:site_tagline).present?
    I18n.t!("default_site_tagline")
  end

  def price_units
    units = []
    units << :sale      if self.enable_price_sale?
    units << :per_month if self.enable_price_per_month?
    units << :per_week  if self.enable_price_per_week?
    units << :per_day   if self.enable_price_per_day?
    units << :per_hour  if self.enable_price_per_hour?
    units
  end

  def transaction_length_options
    units = []
    units << ['month(s)', 'months'] if self.enable_price_per_month?
    units << ['week(s)',  'weeks']  if self.enable_price_per_week?
    units << ['day(s)',   'days']   if self.enable_price_per_day?
    units << ['hour(s)',  'hours']  if self.enable_price_per_hour?
    units
  end

  def price_unit
    units = self.price_units
    if units.blank?
      raise "Must enable a price unit"
    else
      units.first
    end
  end

  protected

  def self.reset_cache
    @instance = nil
  end

  def reset_cache
    self.class.reset_cache
  end

  def refresh_devise_omniauth
    if self.fb_app_id_changed? || self.fb_app_secret_changed?
      Devise.omniauth_configs[:facebook].instance_variable_get("@strategy").client_id = self.fb_app_id
      Devise.omniauth_configs[:facebook].instance_variable_get("@strategy").client_secret = self.fb_app_secret
    end

    if self.tw_app_id_changed? || self.tw_app_secret_changed?
      Devise.omniauth_configs[:twitter].instance_variable_get("@strategy").consumer_key = self.tw_app_id
      Devise.omniauth_configs[:twitter].instance_variable_get("@strategy").consumer_secret  = self.tw_app_secret
    end
  end
end
