ActiveAdmin.register AppLogger, :as => 'Site Logs' do
  menu :label => "Site Logs", :parent => 'Settings', :if => lambda { |tabs| current_active_admin_user.super_admin? }

  config.sort_order = 'created_at_asc'
  scope :guest
  scope :agent
  scope :admin
  scope :superadmin

  controller do
    actions :index, :show
  end

  index do |log|
    column :created_at
    column :url
    column :controller
    column :action
    column :method
    column :user_role
    column :user_email
    default_actions
  end
end