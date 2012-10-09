class InboxEntry < ActiveRecord::Base
  belongs_to :conversation
  belongs_to :user

  def mark_as_read
    self.read = true
  end

  def mark_as_unread
    self.read = false
  end

  # Logical delete
  def delete
    self.deleted_at = Time.now
  end

  def undelete
    self.deleted_at = nil
  end

  def deleted?
    self.deleted_at.present?
  end

  # Inbox entry of the other person involved in the conversation
  def other_party
    InboxEntry.where(:conversation_id => self.conversation_id).where(['user_id <> ?', self.user_id]).first!
  end

end
