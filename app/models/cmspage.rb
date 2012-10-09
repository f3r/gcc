class Cmspage < ActiveRecord::Base
  #default_scope :order => 'id ASC'

  validates_presence_of   :page_title, :message => "101"
  validates_presence_of   :page_url,   :message => "101"

  validates_uniqueness_of :page_url, :message => "Page Already exist with this name"
  validates_exclusion_of  :page_url, :in => proc {url_blacklist} , :message => "Can't use this name as page url"

  before_validation :url_downcase

  scope :active,    where("active")
  scope :inactive,  where("not active")
  scope :system,    where("mandatory")

  has_many :cmspage_menu_sections, :dependent => :destroy
  has_many :menu_sections, :through => :cmspage_menu_sections

  attr_accessible :page_title, :page_url, :description, :active, :mandatory, :type, :meta_description, :meta_keywords

  def activate!
    self.active = true
    self.save
  end

  def deactivate!
    self.active = false
    self.save
  end

  # Get the content of the page
  def self.find_by_url(url)
    Cmspage.where(:active => 1, :page_url => url).first if url
  end

  def self.url_blacklist
    blacklist = active_city_names
    blacklist.concat(['alive', 'search', 'profile'])
  end

  def self.active_city_names
    City.select([:name]).collect{|c| c.name.downcase}
  end

  def to_s
    page_title + " [" + page_url + "]"
  end

  def external?
    false
  end

  def link
    nil
  end

  protected

  def url_downcase
    self.page_url.downcase! if self.page_url_changed?
  end
end