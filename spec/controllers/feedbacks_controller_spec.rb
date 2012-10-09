require 'spec_helper'

describe FeedbacksController do
  before(:each) do
    @emails = ActionMailer::Base.deliveries = []
  end

  it "sends feedback from user" do
    @user = FactoryGirl.create(:user)
    login_as @user

    # mailer = double('mailer', :deliver => true)
    # SystemMailer.should_receive(:user_feedback).and_return(mailer)

    post :create, {
      :type => 'city_suggestion',
      :message => 'Buenos Aires'
    }

    response.should be_redirect

    assert_equal @emails.size, 1
    email = @emails.first
    assert_equal "User Feedback (city_suggestion)",  email.subject
    assert email.body.include?(@user.full_name)
  end

  it "sends feedback from guest" do
    # mailer = double('mailer', :deliver => true)
    # SystemMailer.should_receive(:user_feedback).and_return(mailer)

    post :create, {
      :type => 'city_suggestion',
      :message => 'Buenos Aires'
    }

    response.should be_redirect

    assert_equal @emails.size, 1
    email = @emails.first
    assert_equal "User Feedback (city_suggestion)",  email.subject
    assert email.body.include?('Guest User')
  end

end
