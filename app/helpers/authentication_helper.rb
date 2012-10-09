module AuthenticationHelper

  def current_user?(user)
    current_user && current_user.id == user.id
  end

  def logged_in?
    user_signed_in?
  end

  def is_agent?
    user = current_user
    return false unless user
    user.agent?
  end

  def is_admin?
    user = current_user
    return false unless user
    user.admin?
  end

  def login_required
    authenticate_user!
  end

  def social_enabled
    SiteConfig.fb_app_id.present? || SiteConfig.tw_app_id.present?
  end

  def facebook_enabled
    SiteConfig.fb_app_id.present?
  end

  def twitter_enabled
    SiteConfig.tw_app_id.present?
  end

end
