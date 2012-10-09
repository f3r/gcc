class ContactRequest < ActiveRecord::Base

  validates_presence_of :name, :email, :message

  attr_accessible :name,:email,:message

  # Include the Rakismet model
  include Rakismet::Model

  def self.create_contact(params)
    contact = self.create(params)
    self.rakismet_attrs(:content => params[:message])
    contact
  end
end