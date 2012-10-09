class Message < ActiveRecord::Base
  belongs_to :conversation
  belongs_to :from, :class_name  => 'User'

  def system_msg_id
    msg_id = read_attribute(:system_msg_id)
    msg_id.to_sym if msg_id
  end

  def summary
    if self.system?
      "[#{self.system_message_body}]"
    else
      self.body
    end
  end

  def system_message_body
    I18n.t("workflow.system_msg_#{self.system_msg_id}".to_sym)
  end
end
