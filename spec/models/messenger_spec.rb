require 'spec_helper'

describe Messenger do
  before(:each) do
    @consumer = create(:user, :role => "user")
    @agent = create(:user, :role => "agent")
  end

  context "New users" do
    it "starts with empty inboxes" do
      Messenger.get_conversations(@consumer).should be_empty
      Messenger.get_conversations(@agent).should be_empty
    end
  end

  context "Conversation validations" do
    before(:each) do
      @conversation = Conversation.new
      @conversation.recipient = @agent
      @conversation.body = 'I am interested in your apartment'
    end

    it "requires a sender" do
      assert !Messenger.start_conversation(nil, @conversation)
    end

    it "requires a recipient" do
      @conversation.recipient = nil
      assert !Messenger.start_conversation(@consumer, @conversation)
    end

    it "doesn't send to self" do
      @conversation.recipient = @consumer
      assert !Messenger.start_conversation(@consumer, @conversation)
    end
  end

  context "New conversation" do
    before(:each) do
      @conversation = Conversation.new
      @conversation.recipient = @agent
      @conversation.body = 'I am interested in your apartment'
    end

    it "delivers the message to the recipient" do
      assert Messenger.start_conversation(@consumer, @conversation)
      conversations = Messenger.get_conversations(@agent)
      assert_equal 1, conversations.size
      #same_message?(conversation, @conversation).should be_true
    end

    it "toggles message read/unread" do
      assert Messenger.start_conversation(@consumer, @conversation)
      sender_conversation = Messenger.get_conversations(@consumer).first
      sender_conversation.should be_read
      conversation = Messenger.get_conversations(@agent).first
      conversation.should_not be_read

      # Agent reads the message
      Messenger.mark_as_read(@agent, conversation.id)
      conversation = Messenger.get_conversations(@agent).first
      conversation.should be_read

      # Agent marks the message as unread
      Messenger.mark_as_unread(@agent, conversation.id)
      conversation = Messenger.get_conversations(@agent).first
      conversation.should_not be_read
    end

    it "includes a default message based on the target" do
      @conversation.body = ''
      @conversation.target = create(:inquiry)
      assert Messenger.start_conversation(@consumer, @conversation)
      conversation, messages = Messenger.get_conversation_messages(@consumer, Conversation.last.id)
      messages.size.should == 1
      message = messages.first
      message.system_msg_id.should == :send
      assert message.system
    end

    it "delivers reply to recipients that deleted the message" do
      Messenger.start_conversation(@consumer, @conversation)
      # Agent deletes the message
      conversation = Messenger.get_conversations(@agent).first
      Messenger.archive(@agent, conversation.id)
      Messenger.get_conversations(@agent).should be_empty

      # Consumer insists
      reply = Message.new(:body => "Hey, look at me!")
      Messenger.add_reply(@consumer, conversation.id, reply)

      # Message appears again on agent inbox
      Messenger.get_conversations(@agent).should_not be_empty
    end
  end

  context "Conversation messages" do
    before(:each) do
      @conversation = Conversation.new
      @conversation.recipient = @agent
      @conversation.body = 'I am interested in your apartment'
      Messenger.start_conversation(@consumer, @conversation)
    end

    it "starts with one message" do
      conversation, messages = Messenger.get_conversation_messages(@agent, @conversation.id)
      messages.size.should == 1
      msg = messages.first
      msg.body.should == @conversation.body
      msg.from.should == @consumer
    end

    it "replies to a message" do
      conversation = Messenger.get_conversations(@agent).first

      UserMailer.should_receive(:new_message_reply).and_return(mock(:deliver => true))

      # Agent replies
      conversation = Messenger.get_conversations(@agent).first
      reply = Message.new(:body => "It is interesting, I know")
      Messenger.add_reply(@agent, conversation.id, reply)

      conversation = Messenger.get_conversations(@consumer).first
      conversation.should_not be_read

      conversation, messages = Messenger.get_conversation_messages(@consumer, @conversation.id)
      messages.size.should == 2
      msg2 = messages.last
      msg2.body.should == reply.body
      msg2.from.should == @agent
    end

    it "sends a system message" do
      Messenger.add_system_message(@conversation.id, :inquiry_sent)
      conversation, messages = Messenger.get_conversation_messages(@consumer, @conversation.id)

      messages.size.should == 2
      msg = messages.last

      msg.should be_system
      msg.system_msg_id.to_sym.should == :inquiry_sent
    end
  end

  context "Inbox status" do
    before(:each) do
      @conversation = Conversation.new
      @conversation.recipient = @agent
      @conversation.body = 'I am interested in your apartment'
    end

    it "starts with empty inbox" do
      status = Messenger.inbox_status(@agent)
      status[:total].should == 0
      status[:unread].should == 0
    end

    it "gets updated when receiving a message" do
      Messenger.start_conversation(@consumer, @conversation)
      status = Messenger.inbox_status(@agent)
      status[:total].should == 1
      status[:unread].should == 1
    end

    it "gets updated when marking as read" do
      Messenger.start_conversation(@consumer, @conversation)
      conversation = Messenger.get_conversations(@agent).first
      Messenger.mark_as_read(@agent, conversation.id)
      status = Messenger.inbox_status(@agent)
      status[:total].should == 1
      status[:unread].should == 0
    end

    it "doesn't count archived messages" do
      Messenger.start_conversation(@consumer, @conversation)
      conversation = Messenger.get_conversations(@agent).first
      Messenger.archive(@agent, conversation.id)
      status = Messenger.inbox_status(@agent)
      assert_equal 0, status[:total]
      assert_equal 0, status[:unread]
    end
  end

  context "Target" do
    before(:each) do
      @conversation = Conversation.new
      @conversation.recipient = @agent
      @conversation.body = 'I am interested in your apartment'
    end

    it "supports filtering" do
      inquiry = Inquiry.new(:id => 32)

      @conversation.target = inquiry
      assert Messenger.start_conversation(@consumer, @conversation)

      Messenger.get_conversations(@agent, :target => inquiry)
    end
  end
end