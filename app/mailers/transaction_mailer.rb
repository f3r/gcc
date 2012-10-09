class TransactionMailer < BaseMailer

  def self.mail_dispatcher(event, inquiry)
    case event
    when :request
      self.request_renter(inquiry).deliver!
      self.request_owner(inquiry).deliver!

    when :pre_approve
      self.approve_renter(inquiry).deliver!
      self.approve_owner(inquiry).deliver!

    when :pay
      self.pay_renter(inquiry).deliver!
      self.pay_owner(inquiry).deliver!
    end
  end

  ##############################################################################
  # WORKFLOW STAGE: REQUEST
  ##############################################################################
  # ==Description
  # Email sent to the renter when the renter clicks "Confirm rental request"
  def request_renter(inquiry)
    @user      = inquiry.user
    recipients = "#{@user.full_name} <#{@user.email}>"
    subject    = t("mailers.transaction_request_renter.subject")
    mail(:to => recipients, :subject => subject)
  end

  # ==Description
  # Email sent to the owner when the renter clicks "Confirm rental request"
  def request_owner(inquiry)
    @user      = inquiry.product.user
    @renter    = inquiry.user
    recipients = "#{@user.full_name} <#{@user.email}>"
    subject    = t("mailers.transaction_request_owner.subject")

    mail(:to => recipients, :subject => subject)
  end

  ##############################################################################
  # WORKFLOW STAGE: AGENT APPROVAL
  ##############################################################################
  # ==Description
  # Email sent to the renter when the owner clicks "Approve Rental Request"
  def approve_renter(inquiry)
    @inquiry   = inquiry
    @user      = inquiry.user
    recipients = "#{@user.full_name} <#{@user.email}>"
    subject    = t("mailers.transaction_approve_renter.subject")

    mail(:to => recipients, :subject => subject)
  end

  # ==Description
  # Email sent to the owner when the owner clicks "Approve Rental Request"
  def approve_owner(inquiry)
    @user      = inquiry.product.user
    @renter    = inquiry.user

    recipients = "#{@user.full_name} <#{@user.email}>"
    subject    = t("mailers.transaction_approve_owner.subject")

    mail(:to => recipients, :subject => subject)
  end

  ##############################################################################
  # WORKFLOW STAGE: AFTER PAYMENT
  ##############################################################################
  # ==Description
  # Email sent to the renter when the payment is finalized
  def pay_renter(inquiry)
    @user      = inquiry.user
    @owner     = inquiry.product.user
    @product   = inquiry.product
    recipients = "#{@user.full_name} <#{@user.email}>"
    subject    = t("mailers.transaction_pay_renter.subject")

    mail(:to => recipients, :subject => subject)
  end

  # ==Description
  # Email sent to the owner when the payment is finalized
  def pay_owner(inquiry)
    @user      = inquiry.product.user
    @renter    = inquiry.user
    @product   = inquiry.product
    recipients = "#{@user.full_name} <#{@user.email}>"
    subject    = t("mailers.transaction_pay_owner.subject")

    mail(:to => recipients, :subject => subject)
  end

end
