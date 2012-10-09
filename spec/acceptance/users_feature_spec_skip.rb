require 'acceptance/acceptance_helper'

feature 'Users feature', %q{
  As a user
  I should be able to
} do

  scenario 'signup' do

    visit '/signup'

    page.should have_content(I18n.translate(:create_new_account))

    fill_in 'user[name]', :with => 'Test'
    fill_in 'user[email]', :with => 'test@email.com'

    fill_in 'user[password]', :with => 'password123'
    fill_in 'user[password_confirmation]', :with => 'password123'

    click_button 'Create account'

  end

  scenario 'signup using my facebook account' do
    pending
  end

  scenario 'confirm my account' do
    Heypal::User.stub!(:confirm).and_return(true)

    visit '/users/confirm?confirmation-token=somevalidconfirmationcode'

    page.should have_content(I18n.translate(:user_confirmed))

  end

  scenario 'reject invalid confirmation code' do
    Heypal::User.stub!(:confirm).and_return(false)

    visit '/users/confirm?confirmation-token=someinvalidconfirmationcode'

    page.should have_content(t(:invalid_confirmation_code))
  end

  scenario 'resend my confirmation code' do
    Heypal::User.stub!(:resend_confirmation).and_return(true)

    visit '/users/confirm'

    page.should have_content(t(:resend_confirmation))

    fill_in 'email', :with => 'test@testemail.com'

    click_button t(:resend_confirmation)

    page.should have_content(t(:confirmation_email_sent))
    page.status_code.should == 200
  end

  scenario 'reset my password' do

    visit '/users/reset_password'

    page.should have_content(t(:reset_password))

    Heypal::User.stub!(:reset_password).and_return(true)

    click_button t(:submit)

    save_and_open_page

    page.should have_content(t(:password_reset_instruction_sent))
    page.status_code.should == 200
  end

  scenario 'confirm my reset password' do
    pending
  end

  scenario 'sign in using my email and password' do
    visit '/users/login'

    page.should have_content(I18n.t(:login))

    fill_in 'user_email', :with => @user.email
    fill_in 'user_password', :with => @user.password

    click_button 'Login'

    page.should have_content(I18n.t(:sign_out))
  end

  scenario 'signout' do
    visit '/users/logout'

    page.should have_content(I18n.t(:sign_in))
  end
end
