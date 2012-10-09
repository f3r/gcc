class User
  module Social
    extend ActiveSupport::Concern

    included do
      attr_accessor   :oauth_provider, :oauth_uid, :oauth_token, :oauth_secret, :avatar_url, :facebook_fan_page
      attr_accessible :oauth_provider, :oauth_uid, :oauth_token, :oauth_secret, :avatar_url, :facebook_fan_page
      after_save :store_authentication, :if => :oauth_token?
    end

    module ClassMethods

      def new_with_session(params, session)
        super.tap do |user|
          if data = session["devise.oauth_data"]
            session["devise.oauth_data"] = nil
            user.load_data_from_oauth(data)
          end
        end
      end

      def from_oauth(access_token, signed_in_resource=nil)
        auth = Authentication.find_by_provider_and_uid(access_token[:provider], access_token[:uid])
        return auth.user if auth # Login with existing user

        # Create a new user
        user = User.new(:password => Devise.friendly_token[0,20])
        user.load_data_from_oauth(access_token)
        user.save

        user
      end

    end

    def apply_oauth(access_token)
      auth = self.authentications.find_by_provider_and_uid(access_token[:provider], access_token[:uid])
      unless auth
        auth = self.authentications.new(:provider => access_token[:provider], :uid => access_token[:uid])
      end
      auth.token = access_token[:credentials][:token]
      auth.secret = access_token[:credentials][:secret]

      if !self.avatar? && access_token[:info] && access_token[:info].image
        self.avatar_url = access_token.info.image.gsub('square', 'large').gsub('_normal', '')
        self.save
      end

      auth.save!
    end

    def load_data_from_oauth(data)
      case data[:provider].to_sym
      when :facebook
        self.load_data_from_facebook(data)
      when :twitter
        self.load_data_from_twitter(data)
      end
    end

    def load_data_from_facebook(data)
      self.oauth_provider = 'facebook'
      self.oauth_uid      = data.uid
      self.oauth_token    = data.credentials.token

      if data.info
        self.first_name = data.info.first_name
        self.last_name  = data.info.last_name
        self.email      = data.info.email
        if data.info.image
          self.avatar_url = data.info.image.gsub('square', 'large')
        end
      end
    end

    def load_data_from_twitter(data)
      self.oauth_provider = 'twitter'
      self.oauth_uid = data.uid
      self.oauth_token = data.credentials.token
      self.oauth_secret = data.credentials.secret

      self.name = data.info.name
      self.avatar_url = data.info.image.gsub('_normal', '') if data.info.image
    end

    def store_authentication
      # Regenerate the access token
      access_token = {
        :provider => self.oauth_provider,
        :uid => self.oauth_uid,
        :credentials => {
          :token => self.oauth_token,
          :secret => self.oauth_secret
        }
      }
      self.apply_oauth(access_token)
    end

    def oauth_token?
      self.oauth_token.present?
    end

    def authentication_providers
      [:facebook, :twitter]
    end

    def facebook_authentication
      self.provider_authentication(:facebook)
    end

    def twitter_authentication
      self.provider_authentication(:twitter)
    end

    def provider_authentication(provider)
      self.authentications.where(:provider => provider).first
    end

    def authenticated_providers
      auths = []
      self.authentication_providers.each do |provider|
        auths << provider if self.provider_authentication(provider)
      end
      auths
    end

    def not_yet_authenticated_providers
      self.authentication_providers - self.authenticated_providers
    end
  end
end