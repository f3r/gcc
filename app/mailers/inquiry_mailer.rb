class InquiryMailer < BaseMailer
  helper :products

  # ==Description
  # Email sent to the renter when the user inquires about a listing
  def inquiry_confirmed_renter(inquiry)
    @inquiry   = inquiry
    @target    = inquiry.product
    @owner     = inquiry.recipient
    @user      = inquiry.user
    recipient  = "#{@user.full_name} <#{@user.email}>"
    subject    = t('mailers.inquiry_confirmed_renter.subject')

    mail(:to => recipient, :subject => subject)
  end

  # ==Description
  # Email sent to the owner when the user inquires about a listing
  def inquiry_confirmed_owner(inquiry)
    @inquiry   = inquiry
    @target    = inquiry.product
    @owner     = inquiry.recipient
    @renter    = inquiry.user

    recipient  = "#{@owner.full_name} <#{@owner.email}>"
    subject    = t('mailers.inquiry_confirmed_owner.subject')

    mail(:to => recipient, :subject => subject)
  end

  def inquiry_spam(inquiry)
    @inquiry   = inquiry
    @target    = inquiry.product
    @owner     = inquiry.recipient
    @renter    = inquiry.user

    recipient = "#{@owner.full_name} <#{@owner.email}>"
    subject   = t('inquiries.received_spam_subject')

    mail(:to => recipient, :subject => subject)
  end

  # Email sent to the owner to remind abount an inquiry that hasn't been replied
  def inquiry_reminder_owner(inquiry)
    @inquiry   = inquiry
    @target    = inquiry.product
    @owner     = inquiry.recipient
    @renter    = inquiry.user

    recipient  = "#{@owner.full_name} <#{@owner.email}>"
    subject    = t('mailers.inquiry_reminder_owner.subject')

    mail(:to => recipient, :subject => subject)
  end
end