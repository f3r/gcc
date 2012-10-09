require 'spec_helper'

describe PaymentNotificationsController do
  it "processes ipn request" do
    @inquiry = create(:inquiry)
    @transaction = @inquiry.transaction
    @transaction.update_attribute(:state, 'ready_to_pay')
    id = @transaction.transaction_code

    ActiveMerchant::Billing::Integrations::Paypal::Notification.stub(:new => stub(:item_number => id, :item_id => id, :acknowledge => true, :complete? => true))

    post :create, :item_number => 'abc', :mc_gross => "300.00"
    response.should be_redirect
    @transaction.reload
    @transaction.paid?.should be_true
  end

  it "processes ipn request multiple" do
    @inquiry = create(:inquiry)
    @transaction = @inquiry.transaction
    @transaction.update_attribute(:state, 'ready_to_pay')
    id = @transaction.transaction_code

    ActiveMerchant::Billing::Integrations::Paypal::Notification.stub(:new => stub(:item_number => id, :item_id => id, :acknowledge => true, :complete? => true))

    #Let's post 3 requests
    (1..3).each do
      post :create, :item_number => 'abc', :mc_gross => "300.00"
      response.should be_redirect
    end
    @transaction.reload
    @transaction.paid?.should be_true
  end

  it "checks the precedence of operators" do
    @inquiry = create(:inquiry)
    @transaction = @inquiry.transaction
    @transaction.update_attribute(:state, 'ready_to_pay')
    id = @transaction.transaction_code

    #We create the stub with acknowledge => false
    ActiveMerchant::Billing::Integrations::Paypal::Notification.stub(:new => stub(:item_number => id, :item_id => id, :acknowledge => false, :complete? => true))

    post :create, :item_number => 'abc', :mc_gross => "300.00"

    @transaction.reload
    @transaction.ready_to_pay?.should be_true
  end

end
