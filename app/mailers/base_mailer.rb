class BaseMailer < ActionMailer::Base
  layout 'user_email'
  helper :application, :routes
  default :from => SiteConfig.mailer_sender
  default :bcc  => SiteConfig.mail_bcc
end