module ControllableUser
  def current_user
    # Allow controlling a different user
    u = super
    u.controlled_user if u
  end
end