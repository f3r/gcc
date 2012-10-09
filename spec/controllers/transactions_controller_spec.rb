require 'spec_helper'

describe TransactionsController do
  before(:each) do
    #@request.accept = 'application/json'
    @guest   = create(:user, :role => "user")
    @agent   = create(:user, :role => "agent")
    @place   = create(:published_place, :user => @agent)
    @inquiry = create(:inquiry, :product => @place.product, :user => @guest)
    @conversation = create(:conversation, :target => @inquiry, :sender => @guest)
    @transaction = @inquiry.transaction
  end

  context 'workflow' do
    it "starts with a transaction on initial state" do
      @transaction.state.should == "initial"
    end

    it 'transitions to requested' do
      login_as @guest
      @transaction.user_id.should == @guest.id

      xhr :put, :update, :id => @transaction.id, :event => 'request'
      response.should be_success

      @transaction.reload
      @transaction.state.should == 'requested'
    end

    it 'sends email notifications' do
      login_as @guest
      TransactionMailer.should_receive(:request_renter).and_return(double('Mailer', :deliver! => true))
      TransactionMailer.should_receive(:request_owner).and_return(double('Mailer', :deliver! => true))
      xhr :put, :update, :id => @transaction.id, :event => 'request'
    end

    it 'transitions to ready_to_pay' do
      login_as @agent
      @transaction.update_attribute(:state, 'requested')

      xhr :put, :update, :id => @transaction.id, :event => 'pre_approve'
      response.should be_success
      @transaction.reload
      @transaction.state.should == 'ready_to_pay'
    end

    it 'transition to paid' do
      login_as @guest
      @transaction.update_attribute(:state, 'ready_to_pay')

      xhr :put, :update, :id => @transaction.id, :event => 'pay'
      response.should be_success
      @transaction.reload
      @transaction.state.should == 'paid'
    end

    it 'doesnt allow a user to request a transaction from another user' do
      @guest2 = create(:user, :role => "user")
      login_as @guest2

      assert_raise Workflow::TransitionHalted  do
        xhr :put, :update, :id => @transaction.id, :event => 'request'
      end
    end

    it 'doenst allow agent to pre-approve a transaction from another user' do
      @transaction.update_attribute(:state, 'requested')
      @agent2 = create(:user, :role => "agent")
      login_as @agent2

      assert_raise Workflow::TransitionHalted  do
        xhr :put, :update, :id => @transaction.id, :event => 'pre_approve'
      end
    end

    # it "handles paypal payment" do
    #   @transaction.update_attribute(:state, 'ready_to_pay')
    #   post :pay, :code => @transaction.transaction_code, :amount => 299
    #   response.should be_success
    #
    #   @transaction.reload
    #   @transaction.state.should == 'paid'
    # end
  end
end
