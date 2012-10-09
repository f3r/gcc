class Comment < ActiveRecord::Base
#  using_access_control
  belongs_to :place
  belongs_to :user
  belongs_to :product

  has_many :answers, :class_name => "Comment", :foreign_key => "replying_to", :dependent => :destroy
  belongs_to :question, :class_name => "Comment", :foreign_key => "replying_to", :counter_cache => true

  validates_presence_of [:user_id, :comment]

  #validate :validates_replying_to

  #default_scope :order => 'created_at desc'
  scope :all, :order => 'created_at desc'
  scope :questions, where("replying_to is NULL")

  def reply
    self.answers.first
  end

  # Checks if the replying_to id exists or not
  # def validates_replying_to
  #   self['replying_to'] and Comment.find(self['replying_to']).blank?
  # end
end