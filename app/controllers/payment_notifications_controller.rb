class PaymentNotificationsController < ApplicationController
  protect_from_forgery :except => [:create]

  def create
    # You maybe want to log this notification
    notify = ActiveMerchant::Billing::Integrations::Paypal::Notification.new request.raw_post
    transaction_code = notify.item_id

    @transaction = Transaction.find_by_transaction_code(transaction_code)
    if !@transaction.paid? && notify.acknowledge #&& notify.complete?
      @result = @transaction.received_payment!(params)
    end

    flash[:notice] = "Payment Processed Successfuly!"
    redirect_to root_url
  end
end
