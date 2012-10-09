class Messenger
  def self.get_conversations(user, filters = {})
    conditions = {:user_id => user.id, :deleted_at => nil}

    if filters[:target]
      target = filters[:target]
      conditions['conversations'] = {:target_id => target.id, :target_type => target.class}
    end

    inbox_entries = InboxEntry.where(conditions).order('inbox_entries.created_at DESC').all(:include => [:conversation])
    conversations = []
    inbox_entries.each do |inbox_entry|
      conversation = inbox_entry.conversation
      conversation.from = conversation.other_party(user)
      conversation.body = conversation.last_message.summary
      conversation.read = inbox_entry.read
      conversations << conversation
    end
    conversations
  end

  def self.get_conversation_messages(user, conversation_id)
    inbox_entry = InboxEntry.where(:user_id => user.id, :conversation_id => conversation_id).first!
    conversation = inbox_entry.conversation
    [conversation, conversation.messages]
  end

  def self.start_conversation(sender, conversation)
    return false unless sender && conversation
    conversation.sender = sender
    return false unless conversation.valid?

    recipient = conversation.recipient
    return false unless recipient && recipient != sender

    # Create the conversation
    conversation.save!

    first_message = conversation.messages.build(:body => conversation.body, :from => sender)

    if first_message.body.present?
      first_message.save!
    elsif conversation.target
      conversation.target.add_default_message
    end

    # Insert it into inboxes
    InboxEntry.create!(:conversation => conversation, :user => sender, :read => true)
    InboxEntry.create!(:conversation => conversation, :user => recipient)

    return true
  end

  def self.add_reply(user, conversation_id, message, on_inquiry=false)
    return false unless message.valid?

    sender_inbox_entry = InboxEntry.where(:user_id => user.id, :conversation_id => conversation_id).first!
    conversation = sender_inbox_entry.conversation

    message.from = user
    conversation.messages << message

    recipient_inbox_entry = sender_inbox_entry.other_party
    recipient_inbox_entry.mark_as_unread
    recipient_inbox_entry.undelete
    recipient_inbox_entry.save!

    # Notifiy recipient only on message not on message with inquiry
    if !on_inquiry
      recipient = recipient_inbox_entry.user
      UserMailer.new_message_reply(recipient, message).deliver
    end
  end

  def self.add_system_message(conversation_id, system_msg_id)
    message = Message.new(:system => true, :system_msg_id => system_msg_id)
    conversation = Conversation.find(conversation_id)

    conversation.messages << message
  end

  def self.mark_as_read(user, conversation_id)
    inbox_entry = InboxEntry.where(:user_id => user.id, :conversation_id => conversation_id).first!
    inbox_entry.mark_as_read
    inbox_entry.save!
  end

  def self.mark_as_unread(user, conversation_id)
    inbox_entry = InboxEntry.where(:user_id => user.id, :conversation_id => conversation_id).first!
    inbox_entry.mark_as_unread
    inbox_entry.save!
  end

  # Retrieve the number of unread messages and the total count
  def self.inbox_status(user)
    conditions = {:user_id => user.id, :deleted_at => nil}
    total  = InboxEntry.where(conditions).count
    unread = InboxEntry.where(conditions).where(:read => false).count

    {:total => total, :unread => unread}
  end

  def self.archive(user, conversation_id)
    inbox_entry = InboxEntry.where(:user_id => user.id, :conversation_id => conversation_id).first!
    inbox_entry.delete
    inbox_entry.save!
  end
end