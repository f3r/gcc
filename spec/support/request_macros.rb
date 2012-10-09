module RequestMacros
  def login_as(user)
    visit '/users/login'
    fill_in 'user[email]',    :with => user.email
    fill_in 'user[password]', :with => user.password
    click_button 'Login'
  end
end