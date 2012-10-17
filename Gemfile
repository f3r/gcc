source :rubygems

gem 'rails', '3.2.8'
gem 'mysql2'
gem 'memcachier'
gem 'dalli'

gem 'paperclip', "~> 3.0"
gem 'remotipart', '~> 1.0'
gem 'aws-sdk'
gem 'plupload-rails'

gem 'devise'
gem 'dynamic_form'
gem 'formtastic', '~> 2.1.0'
gem 'omniauth'
gem 'omniauth-facebook'
gem 'omniauth-twitter'

gem "haml", ">= 3.0.0"
gem "haml-rails"
gem 'sass-rails',   '~> 3.2.3'
gem 'jquery-rails',  '~>1.0.18'
gem 'less-rails-bootstrap'

gem 'activeadmin'
gem 'activemerchant'
gem 'therubyracer'
gem 'rakismet'
gem 'newrelic_rpm'
gem 'exception_notification'
gem "meta_search", '>= 1.1.0.pre'
gem 'money'
gem 'google_currency'
gem 'declarative_authorization'
gem 'will_paginate', '= 3.0.2'
gem 'workflow'
gem "friendly_id", "~> 4.0.1"
gem "acts_as_relation"
gem 'simple_enum'
gem 'dynamic_sitemaps'
gem 'mail_view',  :git => 'git://github.com/37signals/mail_view.git'
gem 'geonames'
gem 'geocoder'
gem 'localized_country_select'
gem 'valid_email', :require => 'valid_email/email_validator' # Don't need MX validations
gem 'validates_timeliness', '~> 3.0.2'
gem 'nokogiri', "~> 1.5.5"

group :assets do
  gem 'coffee-rails', "~> 3.2.1"
  gem 'uglifier',     ">= 1.0.3"
end

group :development do
  gem 'quiet_assets'
  gem 'heroku_san'
  gem 'translate-rails3', :require => 'translate'
  gem 'colorize'
  gem 'curb'
  gem 'sqlite3' #this one is require for heroku db:pull (taps)
  #gem 'pry'
end

group :test do
  gem 'faker'
  gem 'database_cleaner'
  gem 'factory_girl_rails', "~> 3.0"
  gem 'capybara'
  gem 'launchy'
end

group :development, :test do
  gem 'rspec-rails'
  gem 'debugger', "~> 1.2.0"
  #gem 'jazz_hands'
end

group :production do
  gem 'crashlog'
end
