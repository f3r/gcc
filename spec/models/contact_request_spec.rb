require 'spec_helper'

describe ContactRequest do
  before(:each) do
    @user = create(:user)
    @contactRequest = ContactRequest.create(:name => "Test", :email=>"test@test.com",:subject=>"Test Subject",:message => "Test Message")
  end

  it "doesn't create a contact request without name" do
    contact = ContactRequest.create( :email=>"test@test.com", :message => "Test Message")
    contact.should_not be_persisted
  end

  it "doesn't create a contact request without email" do
    contact = ContactRequest.create( :name => "Test", :message => "Test Message")
    contact.should_not be_persisted
  end

  it "doesn't create a contact request without a message" do
    contact = ContactRequest.create( :name => "Test", :email=>"test@test.com" )
    contact.should_not be_persisted
  end
end