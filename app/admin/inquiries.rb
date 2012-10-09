ActiveAdmin.register Inquiry do
  menu :priority => 5, :parent => 'E-Commerce'
  actions :index, :show

  scope :all, :default => true
  scope :without_reply

  filter :user
  filter :target_type
  filter :created_at

  index do |inquiry|
    id_column
    column :user,   :sortable => :user_id
    column :listing, :sortable => :product_id
    column :created_at
    default_actions
  end

  show do |inquiry|
    attributes_table do
      rows :id, :user, :listing, :check_in, :length_stay, :length_stay_type, :guests, :created_at
    end
    if inquiry.conversation
      panel 'Conversation' do
        attributes_table_for inquiry.conversation do
          inquiry.conversation.messages.each do |m|
            row (m.system)? 'System' : m.from.full_name do
              if m.system
                m.system_msg_id
              else
                m.body
              end
            end
          end
        end
      end
    end
  end
end
