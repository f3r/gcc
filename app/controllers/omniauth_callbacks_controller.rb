class OmniauthCallbacksController < Devise::OmniauthCallbacksController
  def facebook
    access_token = request.env["omniauth.auth"]
    access_token.slice!(:uid, :provider, :info, :credentials)
    handle_provider(access_token)
  end

  def twitter
    access_token = request.env["omniauth.auth"]
    access_token.slice!(:uid, :provider, :info, :credentials)
    access_token[:info].slice!(:name, :image) # Avoid CookieOverflow
    handle_provider(access_token)
  end

  private

  def handle_provider(access_token)
    if current_user
      # Link account to existing user
      @user = current_user
      @user.apply_oauth(access_token)
    else
      # Create a new user or login to existing one
      @user = User.from_oauth(access_token)
    end

    if @user && @user.persisted?
      flash[:notice] = I18n.t "devise.omniauth_callbacks.success", :kind => access_token.provider
      sign_in_and_redirect @user, :event => :authentication
    else
      session["devise.oauth_data"] = access_token
      redirect_to new_user_registration_url
    end
  end
end