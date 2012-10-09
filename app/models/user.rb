require 'declarative_authorization/maintenance'
require 'valid_email'
class User < ActiveRecord::Base
  devise :database_authenticatable, # Encrypting Password and validating authenticity of user
         :registerable,             # Users can sign up :)
         :recoverable,              # Reset user password
         :trackable,                # Tracks:
                                    #   * sign_in_count      - Increased every time a sign in is made (by form, openid, oauth)
                                    #   * current_sign_in_at - A tiemstamp updated when the user signs in
                                    #   * last_sign_in_at    - Holds the timestamp of the previous sign in
                                    #   * current_sign_in_ip - The remote ip updated when the user sign in
                                    #   * last_sign_in_ip    - Holds the remote ip of the previous sign in
         :validatable,              # Email/Pwd validation
         :token_authenticatable,    # Generate auth token and validates it
         :omniauthable              # OAuth support

  include User::Social
  include User::Roles
  include User::Avatar

  attr_accessible :first_name, :last_name, :email, :gender, :birthdate, :timezone, :phone_mobile, :avatar, :avatar_url, :password, :password_confirmation,
                  :remember_me, :passport_number, :signup_role, :address_attributes, :delete_avatar, :paypal_email

  has_one :address
  has_one :bank_account
  has_one :preferences

  has_many :authentications,  :dependent => :destroy
  has_many :products,         :dependent => :destroy
  has_many :comments,         :dependent => :destroy
  has_many :favorites,        :dependent => :destroy
  has_many :alerts,           :dependent => :destroy
  has_many :inquiries,        :dependent => :destroy

  attr_accessor :terms, :skip_welcome
  accepts_nested_attributes_for :address, :update_only => true

  validates :paypal_email, :email => true, :if => Proc.new {|user| user.paypal_email.present?}

  before_save :ensure_authentication_token, :check_avatar_url, :set_paypal_email
  before_save :check_delete_avatar
  after_create :send_on_create_welcome_instructions
  after_create :add_user_preferences

  scope :consumer, where("role = 'user'")
  scope :agent,    where("role = 'agent'")
  scope :admin,    where("role = 'admin' or role = 'superadmin'")

  # Creates a new user with a random password automatically
  def self.auto_signup(name, email, role = 'user', message = nil)
    first_name, last_name = name.split(' ', 2)

    user = User.find_by_email(email)

    unless user
      user = self.new(
        :first_name => first_name,
        :last_name => last_name,
        :email => email
      )
      user.signup_role = role
    end

    if user.save_without_password
      UserMailer.auto_welcome(user, message).deliver
    end

    user
  end

  def save_without_password
    unless self.password
      self.password = self.password_confirmation = Devise.friendly_token[0,20]
    end

    self.generate_set_password_token
    self.skip_welcome = true
    Authorization::Maintenance::without_access_control do
      self.save
    end
  end

  def self.send_invitations(list, role, message)
    count = 0
    list.each do |user_hash|
      user = User.auto_signup(user_hash[:name], user_hash[:email], role, message)
      count += 1 if user.persisted?
      user.phone_mobile = user_hash[:phone] if user_hash[:phone]
      user.created_at = user_hash[:created_at] if user_hash[:created_at]
      user.save
    end
    count
  end

  def full_name
    [first_name, last_name].compact.join(' ')
  end

  def has_reset_password
    self.sign_in_count != 0 || !self.reset_password_token.present?
  end

  def anonymized_name
    initials = []
    initials << "#{first_name[0]}." if first_name
    initials << "#{last_name[0]}." if last_name
    initials.join(' ')
  end

  def age
    return unless self.birthdate
    now = Time.now.utc.to_date
    now.year - birthdate.year - ((now.month > birthdate.month || (now.month == birthdate.month && now.day >= birthdate.day)) ? 0 : 1)
  end

  def name=(a_name)
    self.first_name, self.last_name = a_name.split(' ', 2)
  end

  def signup_role=(a_role)
    return false unless [:user, :agent].include?(a_role.to_sym)
    self.role = a_role
  end

  def change_preference(pref, value)
   if self.preferences
     self.preferences.update_attribute(pref, value)
   end
  end

  def generate_set_password_token
    # We use the saeme mechanism as password reset
    self.generate_reset_password_token
  end

  # Retrieves the other published products of this user
  def other_published_products(except = nil)
    #retrive the products of this user
    products = SiteConfig.product_class.published.where('user_id = ?', self.id)
    products = products.where('products.id <> ?', except.product.id) if except
    products
  end

  def prefered_language
    self.preferences.locale if self.preferences
  end

  def prefered_currency
    self.preferences.currency if self.preferences
  end

  def prefered_city
    self.preferences.city if self.preferences
  end

  def prefered_speed_unit
    self.preferences.speed_unit_id if self.preferences
  end

  def prefered_size_unit
    self.preferences.size_unit_id if self.preferences
  end

  # Overrides active_for_authentication? from Devise::Models::Activatable for disabling from admin
  # by verifying whether a user is disabled
  def active_for_authentication?
    super && !disabled?
  end

  # Overwrites invalid_message from Devise::Models::Authenticatable to define
  # the correct reason for blocking the sign in.
  def inactive_message
    disabled? ? :disabled : super
  end

  # Disables the user
  def disable
    self.disabled = true
    self.save
  end

  ## Disables the user and unpublishes things
  def disable_and_unpublish_listings
    self.transaction do
      self.disable
      self.products.published.update_all(:published => false)
      self.save
    end
  end

private

  def send_on_create_welcome_instructions
    RegistrationMailer.welcome_instructions(self).deliver unless skip_welcome
  end

  # checks if avatar_url is set and updates the avatar if avatar_url is an image
  def check_avatar_url
    if self.avatar_url
      remote_avatar = open(self.avatar_url) rescue nil
      self.avatar = remote_avatar if remote_avatar
    end
  end

  def check_delete_avatar
    if delete_avatar
      self.avatar.clear if avatar && !avatar.dirty?
    end
  end

  def add_user_preferences
    self.build_preferences
  end

  def set_paypal_email
    if self.agent? || self.admin?
      self.paypal_email = self.email if !self.paypal_email.present?
    end
  end

end
