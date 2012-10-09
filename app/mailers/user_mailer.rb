class UserMailer < BaseMailer
  # ==Description
  # Email sent when the user receives a question
  def new_question(user, question)
    @user      = user
    @question  = question
    # we need the get the actual product - so the seo path is rendered correctly
    @product   = question.product.as_product
    @from      = @question.user
    recipients = "#{user.full_name} <#{user.email}>"
    subject    = t('mailers.new_question.subject', :sender => @from.anonymized_name)

    mail(:to => recipients, :subject => subject)
  end

  def new_question_reply(user, question)
    @user      = user
    @question  = question
    # we need the get the actual product - so the seo path is rendered correctly    
    @product   = question.product.as_product
    recipients = "#{user.full_name} <#{user.email}>"
    subject    = t('mailers.new_question_reply.subject')

    mail(:to => recipients, :subject => subject)
  end

  # ==Description
  # Email sent when the user receives a message
  def new_message_reply(user, message)
    @user      = user
    @message   = message
    from       = @message.from
    recipients = "#{user.full_name} <#{user.email}>"
    subject    = t('mailers.new_message_reply.subject', :sender => from.anonymized_name)

    mail(:to => recipients, :subject => subject)
  end

  # ==Description
  # Email sent when we create an user account automatically (from an inquiry)
  def auto_welcome(user, message = nil)
    @user      = user
    recipients = "#{user.full_name} <#{user.email}>"
    subject    = t('mailers.auto_welcome.subject')
    @message   = message || t('mailers.auto_welcome.content')
    mail(:to => recipients, :subject => subject)
  end
  
  def password_reset_reminder(user)
    @user      = user
    recipients = "#{user.full_name} <#{user.email}>"
    subject    = t('mailers.reset_password_reminder_instructions.subject')
    mail(:to => recipients, :subject => subject)
  end
end