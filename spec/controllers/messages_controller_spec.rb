require 'spec_helper'

describe MessagesController do
  before(:each) do
    @user = create(:user)
    login_as @user
  end

  it "list conversations" do
    get :index
    response.should be_success
  end

  it "adds a reply to a conversation" do
    mailer = double(:deliver => true)
    Messenger.should_receive(:add_reply).with(@user, '23', an_instance_of(Message)).and_return(true)

    put :update, :id => 23, :message => {:body => 'adding a reply'}
    response.should redirect_to(message_path(23))

    assigns(:message).body.should == 'adding a reply'
  end

  it "marks a conversation as unread" do
    Messenger.should_receive(:mark_as_unread).with(@user, '23').and_return(true)
    put :mark_as_unread, :id => 23
    response.should redirect_to(messages_path)
  end
end