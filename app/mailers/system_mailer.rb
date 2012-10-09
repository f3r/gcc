class SystemMailer < BaseMailer
  default :to  => SiteConfig.support_email
  default :bcc => SiteConfig.mail_bcc

  # ==Description
  # Email sent when the user sends feedback
  def user_feedback(user, type, message)
    @user = user
    @type = type
    @message = message

    mail(:subject => "User Feedback (#{type})")
  end

  # ==Description
  # Email sent when a user sends a suggestion
  def user_contact(contact)
    @contact = contact
    mail(:subject => "Contact request from (#{@contact[:name]})")
  end

  # ==Description
  # Email sent when the TSE admin needs to pay a certain agent
  def time_to_pay(payment)
    @payment = payment
    mail(:subject => "Time to pay", :to => SiteConfig.mail_sysadmins)
  end
end