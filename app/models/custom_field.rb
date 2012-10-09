class CustomField < ActiveRecord::Base
  as_enum :type, [:string, :integer, :dropdown, :checkbox, :yes_no, :yes_no_text, :date, :checkbox_group]

  default_scope order("position ASC")

  validates_presence_of :label, :name

  def options
    case self.type
    when :yes_no, :yes_no_text
      self.class.YES_NO_HASH
    else
      self.values.split(/[ ]*,[ ]*/) # Separated by commas, ignore spaces
    end
  end

  def name_extra
    "#{self.name}_extra"
  end

  # Why this hash? the keys can be from I18n for different langs
  # But the values has to remain same - so the js and code checking will work fine :)
  def self.YES_NO_HASH
    #TODO have the no and yes labels translated?
    #Let's give 'No' preference ;)
    {"No" => "no", "Yes" => "yes"}
  end

  def self.DATE_FORMATS
    ['yy-mm-dd', 'dd-mm-yy', 'dd/mm/yy']
  end

end
