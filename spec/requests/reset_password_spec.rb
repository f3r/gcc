require 'spec_helper'

describe "Reset password" do
  before(:each) do
    @user = create(:user)
  end

  it "creates and sends a new password reset token" do
    @user.reset_password_token.should be_nil
    mailer = double('mailer', :deliver => true)
    Devise::Mailer.should_receive(:reset_password_instructions).and_return(mailer)
    post user_password_path, :user => {:email => @user.email}
    response.should be_redirect

    @user.reload
    @user.reset_password_token.should_not be_nil
  end

  it "shows the reset password form" do
    @user.send(:generate_reset_password_token)
    @user.save!

    get edit_user_password_path, :reset_password_token => @user.reset_password_token
    response.should be_success
  end


  it "redirects to login if the token was already used" do
    get edit_user_password_path, :reset_password_token => 'nonono'
    response.should be_redirect
  end

  it "returns error for a nonexistent email" do
    post user_password_path, :user => {:email => Faker::Internet.email}
    response.should be_success
    response.body.should include('Email not found')
  end

  it "changes password using token" do
    @user.send(:generate_reset_password_token)
    @user.save!

    put user_password_path, :user => {:password => 'newpassword', :reset_password_token => @user.reset_password_token}
    response.should be_redirect

    @user.reload
    @user.should be_valid_password('newpassword')
  end

  it "cannot change password using invalid token" do
    @user.send(:generate_reset_password_token)
    @user.save!

    put user_password_path, :user => {:password => 'newpassword', :reset_password_token => 'invalid_token'}
    response.should be_success
    response.body.should include('token is invalid')

    @user.reload
    @user.should_not be_valid_password('newpassword')
  end
end