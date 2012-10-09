class SessionsController < Devise::SessionsController
  layout 'single'

  append_after_filter :link_social_account, :only => :create

  def new
    # Store the referral URL for redirecting after login
    session[:user_return_to] = params[:ref] if params[:ref].present?
    super
  end

  protected

  def link_social_account
    if current_user && params[:user] && params[:user][:oauth_token]
      current_user.attributes = params[:user].slice(:oauth_provider, :oauth_token, :oauth_secret, :oauth_uid, :avatar_url)
      if current_user.save
        flash[:notice] = t(:oauth_connected, :provider => params[:user][:oauth_provider])
      end
    end
  end
end
