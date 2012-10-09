ActiveAdmin.register Payment do
  menu :label => "Payments", :parent => 'Settings', :if => lambda { |tabs| current_active_admin_user.super_admin? }
  config.clear_sidebar_sections!

  index do |place|
    id_column
    column :recipient
    column :amount
    column(:state){|payment| status_tag(payment.state) }
    column :pay_at
    default_actions
  end

  form do |f|
    f.inputs do
      f.input :recipient
      f.input :transaction
      f.input :currency
      f.input :amount
      f.input :state, :as => :select, :collection => Payment.workflow_spec.states.keys
      f.input :note
      f.input :pay_at
    end
    f.buttons
  end

  action_item :only => :show do
    link_to('Pay', pay_admin_payment_path(payment), :method => :post) if !payment.paid?
  end

  member_action :pay, :method => :post do
    payment = resource
    payment.do_payment!
    flash[:success] = "Payment sent"
    redirect_to admin_payment_path(payment)
  end
end