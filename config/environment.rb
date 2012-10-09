# Load the rails application
require File.expand_path('../application', __FILE__)

# Initialize the rails application
HeyPalFrontEnd::Application.initialize!

HeyPalFrontEnd::Application.configure do

  Paperclip::Attachment.default_options.merge!({
    :storage => APP_CONFIG['STORAGE'] || :s3,
    :s3_protocol => 'https',
    :s3_credentials => {
      :access_key_id => S3_ACCESS_KEY_ID,
      :secret_access_key => S3_SECRET_ACCESS_KEY
    },
    :bucket => S3_BUCKET
  })

  config.after_initialize do
    ActionMailer::Base.default_url_options[:host] = SiteConfig.site_url.gsub('http://', '')
  end
end