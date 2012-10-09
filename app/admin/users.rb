ActiveAdmin.register User do
  menu :priority => 1
  actions :all, :except => [:destroy]

  controller do
    helper 'admin/users'

    def index
      # Why scopes defined here?
      # Because the scope lables has to be translated, if we use the scope block, the translation won't happen
      # as active admin gets initialized before the translations get into action
      # So I am just delaying the scope creation, until the index page is requested
      active_admin_config.scopes.clear
      active_admin_config.scope :all, :default => true
      active_admin_config.scope I18n.t('users.role_user'), :consumer
      active_admin_config.scope I18n.t('users.role_agent'), :agent
      active_admin_config.scope I18n.t('users.role_admin'), :admin
      index!
    end

    def new
      @user = User.new
      @user.class_eval do
        attr_accessor :send_invitation
        attr_accessor :invitation_text
      end
      
      if !session[:preview_user].present?
        # Transport some extra data in the form
        @user.invitation_text = I18n.t('mailers.auto_welcome.content')
      else
        user_params = Rack::Utils.parse_query(session[:preview_user])
        @user.attributes = user_params
        @user.send_invitation = user_params["send_invitation"]
        @user.invitation_text = user_params["invitation_text"]
        session[:preview_user] = nil
      end
      new!
    end
    
    def create
      @user = User.new
      @user.class_eval do
        attr_accessor :send_invitation
        attr_accessor :invitation_text
      end

      @user.attributes = params[:user]

      @user.send_invitation = params[:user][:send_invitation]
      @user.invitation_text = params[:user][:invitation_text]
      
      if @user.send_invitation == '1' 
        @user_query = Rack::Utils.build_query(params[:user])
        @mail_template = UserMailer.auto_welcome(@user, @user.invitation_text)
        render(:action => "show_email_preview", :layout => "active_admin")
      else
        if @user.save_without_password
          flash[:success] = "User created."
          redirect_to admin_user_path(@user)
        else
          respond_with @user
        end
      end
    end

    def update
      user = resource
      # We need to bypass the attr-accessor to set the role
      user.update_attribute(:role, params[:user][:role])
      update!
    end
  end

  filter :email
  filter :first_name
  filter :last_name
  filter :created_at

  index do |place|
    id_column
    column :email
    column :full_name
    column(:role)         {|user| status_tag(I18n.t("users.role_#{user.role}"), user.role) }
    column :created_at
    column :last_sign_in_at
    column ("Set_Password") { |user| reminder_status(user.has_reset_password)}
    column("Actions")     {|user| user_links_column(user) }
  end

  show do |ad|
    rows = default_attribute_table_rows.reject {|a| a =~ /password|avatar|token|confirm/}
    attributes_table *rows do
      row(:avatar) {|u|
        image_tag(u.avatar.url('thumb')) if u.avatar?
      }
      row("Password set") { |u|
        reminder_status(u.has_reset_password)
      }
    end
  end
  
  form do |f|
    f.inputs do
      [:first_name, :last_name, :email].each do |field|
        f.input field
      end
      if f.object.new_record?
        f.input :send_invitation, :as => :boolean
        f.input :invitation_text, :as => :text
      end
      f.input :role, :as => :select, :collection => [[I18n.t('users.role_user'), 'user'], [I18n.t('users.role_agent'), 'agent'], [I18n.t('users.role_admin'), 'admin']], :include_blank => false

      if !f.object.new_record?
        f.input :gender, :as => :select, :collection => [[t("users.gender_male"), 'male'], [t("users.gender_female"), 'female']]
        [:birthdate, :timezone, :phone_mobile, :avatar, :passport_number, :paypal_email].each do |field|
          f.input field
        end
      end
      f.buttons
    end
  end
  
  collection_action :show_email_preview, :method => :post do
    user_params = Rack::Utils.parse_query(params[:user][:user_query])
    @user = User.new
    @user.attributes = user_params
     
    @user.class_eval do
      attr_accessor :send_invitation
      attr_accessor :invitation_text
    end
     
    @user.send_invitation = user_params["send_invitation"]
    @user.invitation_text = user_params["invitation_text"]
      
    if params[:commit].present? && params[:commit] == I18n.t('users.invitation_preview.back_to_edit')
      session[:preview_user] = params[:user][:user_query]
      redirect_to new_admin_user_path
    else
      if @user.save_without_password
        UserMailer.auto_welcome(@user, user_params["invitation_text"]).deliver
        flash[:success] = "User created and invitation sent."
        redirect_to admin_user_path(@user)
      else
        session[:preview_user] = params[:user][:user_query]
        redirect_to new_admin_user_path
      end
    end
  end
  
  #Disable User
  action_item :only => :show do
    link_to('Disable User', disable_admin_user_path(user), :method => :put,
            :confirm => "Are you sure you want to disable this user?\nNote: Doing so will unpublish all listings this user owns") if !user.disabled?
  end

  member_action :disable, :method => :put do
    user = User.find(params[:id])
    user.disable_and_unpublish_listings
    redirect_to({:action => :show}, :notice => "The user has been disabled")
  end


  # Take control
  action_item :only => :show do
    link_to('Take Control', take_control_admin_user_path(user), :method => :post) if !user.admin?
  end

  member_action :take_control, :method => :post do
    target_user = User.find(params[:id])
    if target_user
      current_admin_user.take_control(target_user)
      sign_in_and_redirect current_admin_user.user
    end
  end

  # Send Password Reset Reminder
  action_item :only => :show do
    if !user.has_reset_password
      link_to("Send Reminder", send_reset_password_reminder_admin_user_path(user), :method => :post,
        :confirm => 'Are you sure you want to send password reset reminder?')
    end
  end

  member_action :send_reset_password_reminder, :method => :post do
    user = User.find(params[:id])
    UserMailer.password_reset_reminder(user).deliver if user
    redirect_to({:action => :show}, :notice => "Sent password reset reminder.")
  end

  collection_action :release_control, :method => :post do
    current_admin_user.release_control
    redirect_to admin_users_path
  end

  action_item :only => :index do
    link_to('Invite from CSV', invite_csv_admin_users_path)
  end

  collection_action :invite_csv, :method => :get do
    render 'admin/invitations/import'
  end

  collection_action :import_invitations, :method => :post do
    if !params[:invitation] || !params[:invitation][:file]
      flash[:success] = "You must select a file"
      redirect_to :action => :invite
    else
      list = CsvImport.to_hashes(params[:invitation][:file])
      count = User.send_invitations(list, params[:invitation][:role], params[:invitation][:message])
      if count > 0
        flash[:success] = "#{count} Invitations sent"
        redirect_to :action => :index
      else
        flash[:error] = "No invitations were sent"
        redirect_to :action => :invite
      end
    end
  end
end
