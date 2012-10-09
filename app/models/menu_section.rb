class MenuSection < ActiveRecord::Base

  before_validation :make_name_lower_case

  validates_presence_of   :name, :message => "Name can't be empty"
  validates_uniqueness_of :name, :message => "Name should be unique"

  has_many :cmspage_menu_sections, :order => "position ASC", :dependent => :destroy

  has_many :cmspages, :through => :cmspage_menu_sections,
    :conditions => "active = 1",
    :include => :cmspage_menu_sections,
    :order => "position ASC"

  def self.main
    self.find_by_name('main')
  end

  def self.user_menu
    self.find_by_name('menu_consumer')
  end

  def self.agent_menu
    self.find_by_name('menu_agent')
  end

  def self.help
    self.find_by_name('help')
  end

  def self.footer
    self.find_by_name('footer')
  end

  private
    def make_name_lower_case
      name.downcase! unless name.blank?
    end
end