require 'spec_helper'

describe User do
  let(:user){ create(:user) }

  context "name=" do
    it "parses the first name and last name" do
      user = User.new

      user.name = "Diego Maradona"
      user.first_name.should == "Diego"
      user.last_name.should == "Maradona"

      user.name = "Diego Armando Maradona"
      user.first_name.should == "Diego"
      user.last_name.should == "Armando Maradona"

      user.name = "Diego"
      user.first_name.should == "Diego"
      user.last_name.should be_nil
    end
  end

  context "Avatar" do
    it "sets and deletes the avatar" do
      user.delete_avatar = true
      mock_avatar = mock(:dirty? => false)
      mock_avatar.should_receive(:clear)
      user.stub(:avatar => mock_avatar)
      user.save.should be_true
    end
  end

  context "Preferences" do

    it "should be an instance of Preferences" do
      user.preferences.should be_an_instance_of(Preferences)
    end

    it "initialy all preferences should be nil" do
      user.prefered_currency.should be_nil
      user.prefered_language.should be_nil
      user.prefered_city.should be_nil
      user.prefered_size_unit.should be_nil
      user.prefered_speed_unit.should be_nil
    end

    it "stores prefered city" do
      city = create(:city)
      user.change_preference(:city, city)
      user.reload
      user.prefered_city.should == city
    end

    it "stores prefered currency" do
      currency = create(:currency)
      user.change_preference(:currency, currency)
      user.reload
      user.prefered_currency.symbol.should == '$'
    end

    it "stores prefered language" do
      locale = create(:locale)
      user.change_preference(:locale, locale)
      user.reload
      user.prefered_language.code.should == 'MyString'
    end

    it "Getting prefered size unit" do
      user.change_preference(:size_unit_id, 0)
      user.reload
      user.prefered_size_unit.should == 0
    end

    it "Getting prefered speed unit" do
      user.change_preference(:speed_unit_id, 0)
      user.reload
      user.prefered_speed_unit.should == 0
    end

  end

  context "OAuth" do
    before(:each) do
      @token = Hashie::Mash.new({'uid' => '1234',
        "provider" => "facebook",
        "credentials" => {
          "token" => "token123",
          "secret" => "secret123",
        },
        "info" => {
          "email" => 'user@facebook.com',
          "first_name" => 'John',
          "last_name" => 'Smith'
        }
      })
    end

    it "stores facebook authentication" do
      user.apply_oauth(@token)
      user.authentications.size.should == 1
      auth = user.authentications.first

      auth.provider.should == 'facebook'
      auth.uid.should == '1234'
      auth.token.should == "token123"
      auth.secret.should == "secret123"
    end

    it "updates facebook authentication" do
      user.apply_oauth(@token)
      @token.credentials.token = "token456"
      user.apply_oauth(@token)
      auth = user.authentications.first

      auth.provider.should == 'facebook'
      auth.uid.should == '1234'
      auth.token.should == "token456"
      auth.secret.should == "secret123"
    end

    it "creates a user from facebook authentication" do
      new_user = User.from_oauth(@token)
      new_user.first_name.should == 'John'
      new_user.last_name.should == 'Smith'
      new_user.email.should == 'user@facebook.com'
      new_user.should be_persisted
      new_user.authentications.size.should == 1
    end

    it "doesn't create a user if it is missing required fields" do
      @token.info.email = nil
      new_user = User.from_oauth(@token)
      new_user.first_name.should == 'John'
      new_user.last_name.should == 'Smith'
      new_user.email.should be_nil
      new_user.should_not be_persisted
    end

    it "retrieves existing user" do
      user.authentications.create!(
        :provider => @token.provider,
        :uid => @token.uid,
        :token => 'token789'
      )

      new_user = User.from_oauth(@token)
      new_user.id.should == user.id
    end

    it "stores authentication" do
      user.authentications.size.should == 0

      user.attributes = {
        :oauth_provider => 'facebook',
        :oauth_token => 'token456',
        :oauth_secret => 'secret456',
        :oauth_uid => '456'
      }

      #user.updated_at = Time.now

      user.save.should be_true
      user.reload

      user.authentications.size.should == 1
      auth = user.authentications.first
      auth.provider.should == 'facebook'
      auth.uid.should == '456'
    end

    it "retrieves linked account info" do
      user.facebook_authentication.should be_nil
      user.not_yet_authenticated_providers.should == [:facebook, :twitter]
      auth = user.authentications.create!(
        :provider => 'facebook',
        :uid => '123',
        :token => 'token789'
      )
      user.facebook_authentication.should == auth
      user.not_yet_authenticated_providers.should == [:twitter]
    end
  end

  context "auto_signup" do
    before(:each) do
      @emails = ActionMailer::Base.deliveries = []
    end

    it "creates a new user account" do
      name = "Stewie Griffin"
      email = "ste@gmail.com"
      user = nil

      expect {
        user = User.auto_signup(name, email)
      }.to change(User, :count).by(1)

      user.should be_persisted # saved
      user.reset_password_token.should_not be_nil
      user.reset_password_sent_at.should_not be_nil
    end
    
    it "Does the autosignup user reset his password?" do
       user = User.auto_signup("Baiju John", "baijucjohn@gmail.com")
       user.has_reset_password.should == false
    end

    it "re-invites existing user" do
      user = create(:agent)
      user2 = User.auto_signup(user.full_name, user.email)
      user2.should == user
      @emails.size.should == 1
    end

    it "invites users" do
      list = [
        { :email => 'user1@email.com', :name => 'User 1' },
        { :email => 'user2@email.com', :name => 'User 2' }
      ]
      msg = 'Hey please signup!'
      expect {
        User.send_invitations(list, 'agent', msg).should == 2
      }.to change(User, :count).by(2)

      @emails.size.should == 2
      @emails[0].body.should include('Hey please signup!')

      user = User.last
      user.should be_agent
    end
  end

  context "associated products of agent" do
    before(:each) do
      @agent = create(:agent)
      @agent2 = create(:agent)
      SiteConfig.stub(:product_class).and_return(Property)
    end

    it "retrieves the other properties owned" do
      place1 = create(:published_place, :user => @agent)
      place2 = create(:published_place, :user => @agent)
      place3 = create(:published_place, :user => @agent2)

      @agent.other_published_products(place1).count.should == 1
      @agent.other_published_products(place2).first.id.should == place1.id
    end
  end

  context "user disable" do

    it "disables him" do
      agent = create(:agent)
      agent.disable
      agent.disabled.should be_true
    end

    it "unpublishes the listings owned" do
      agent = create(:agent)

      pro1 = create(:published_product, :user => agent)
      pro2 = create(:published_product, :user => agent)

      agent.products.published.count.should == 2
      agent.disable_and_unpublish_listings
      agent.products.published.count.should == 0
    end
  end
end
