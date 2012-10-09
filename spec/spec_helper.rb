# This file is copied to spec/ when you run 'rails generate rspec:install'
ENV["RAILS_ENV"] ||= 'test'
require File.expand_path("../../config/environment", __FILE__)
require 'rspec/rails'
#require 'capybara/rspec'
require 'capybara/rails'

# Requires supporting ruby files with custom matchers and macros, etc,
# in spec/support/ and its subdirectories.
Dir[Rails.root.join("spec/support/**/*.rb")].each {|f| require f}

RSpec.configure do |config|
  config.mock_with :rspec
  config.use_transactional_fixtures = true
  config.include Devise::TestHelpers, :type => :controller
  config.include ControllerMacros, :type => :controller
  config.include RequestMacros, :type => :request
  config.include FactoryGirl::Syntax::Methods

  User.attachment_definitions[:avatar][:path] = "public/system/" + User.attachment_definitions[:avatar][:path]
  Photo.attachment_definitions[:photo][:path] = "public/system/" + Photo.attachment_definitions[:photo][:path]
  SiteConfig.attachment_definitions[:fav_icon][:path] = "public/system/" + SiteConfig.attachment_definitions[:fav_icon][:path]
  SiteConfig.attachment_definitions[:logo][:path] = "public/system/" + SiteConfig.attachment_definitions[:logo][:path]
  # SiteConfig.attachment_definitions[:photo_watermark][:path] = "public/system/" + SiteConfig.attachment_definitions[:photo_watermark][:path]

  config.before(:each) do
    # Do not depend on external currency service on test mode
    Currency.any_instance.stub(:from_usd) do |arg|
        arg
      end
    Currency.any_instance.stub(:to_usd) do |arg|
      arg
    end
    Product.any_instance.stub(:geocode).and_return(true)
    SiteConfig.any_instance.stub(:price_units).and_return([:per_month])
  end
end
