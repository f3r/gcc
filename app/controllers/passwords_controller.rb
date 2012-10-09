class PasswordsController < Devise::PasswordsController
  layout 'application'

  def create
    self.resource = User.find_or_initialize_with_errors(Devise.reset_password_keys, resource_params, :not_found)
    if resource.disabled?
      set_flash_message :notice, :disabled
      redirect_to new_user_session_path
      return
    end
    super
  end

  def edit
    self.resource = resource_class.new
    resource.reset_password_token = params[:reset_password_token]
    @user = User.find_by_reset_password_token(params[:reset_password_token])

    unless @user && @user.reset_password_period_valid?
      flash[:error] = "The link to set your password expired. Please login of click on 'Forgot Password'"
      redirect_to new_user_session_path
      return
    end
  end
end
