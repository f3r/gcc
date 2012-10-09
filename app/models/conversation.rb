class Conversation < ActiveRecord::Base
  belongs_to :sender, :class_name  => 'User'
  belongs_to :target, :polymorphic => true

  has_many :messages
  has_many :inbox_entries

  attr_accessor :recipient, :body, :read, :from

  validates_presence_of :sender

  def self.find_by_target(a_target)
    self.where(:target_id => a_target.id, :target_type => a_target.class).first
  end

  def self.without_reply(since = nil)
    conversations = self.select('conversations.*, count(messages.id) replies').joins(:messages).group('conversations.id').having('replies <= 1')
    if since
      conversations = conversations.where(['conversations.created_at > ?', since])
    end
    conversations
  end

  def read?
    self.read
  end

  def last_message
    self.messages.last
  end

  def other_party(user)
    ie = self.inbox_entries.where(['user_id <> ?', user.id]).first
    ie.user if ie
  end

  def inquiry
    self.target
  end

  def target_product
    self.inquiry.product if self.inquiry
  end

  # def recipient_inbox_entry
  #    self.inbox_entries.where(['user_id <> ?', self.sender_id]).first
  #  end
end
