require 'acceptance/acceptance_helper'

feature 'Sessions feature', %q{
  As a user
  I should be able to login
} do

  background do
    @city = FactoryGirl.create(:city)
    @user = FactoryGirl.create(:user)
    @currency = FactoryGirl.create(:currency)
  end

  # scenario 'sign in using my email and password' do
  #   visit '/users/login'

  #   page.should have_content(I18n.t(:login))

  #   fill_in 'user_email', :with => @user.email
  #   fill_in 'user_password', :with => @user.password

  #   click_button 'Login'

  #   page.should have_content(I18n.t(:sign_out))
  # end

  # scenario 'signout' do
  #   visit '/users/logout'

  #   page.should have_content(I18n.t(:sign_in))
  # end
end
