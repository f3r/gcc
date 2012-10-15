module InquiriesHelper
  def transaction_length_options
    opts = SiteConfig.transaction_length_options
    options_for_select(opts)
  end

  def payment_notification_url(inquiry)
    paypal_callback_url
  end
end