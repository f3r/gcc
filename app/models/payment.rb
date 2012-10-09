class Payment < ActiveRecord::Base
  include Workflow
  belongs_to :recipient, :class_name => 'User'
  belongs_to :transaction
  belongs_to :currency

  has_many :payment_logs, :dependent => :destroy

  workflow_column :state

  workflow do
    state :scheduled do
      event :ready, :transitions_to => :ready
    end

    state :ready do
      event :pay, :transitions_to => :paid
      event :fail, :transitions_to => :failed
    end

    state :paid
    state :failed

    after_transition do |from, to, triggering_event, *event_args|
      log_payment(:from => from, :to => to, :triggering_event => triggering_event, :additional_data => event_args[0])
    end
  end

  def set_ready!
    self.ready!
    SystemMailer.time_to_pay(self).deliver
  end

  def do_payment!
    gateway = self.class.init_paypal_gateway
    response = gateway.transfer(self.amount,
                                self.recipient.email,
                                :subject => "Remaining amount",
                                :note => self.note)
    if response.success?
      self.pay!(response)
    else
      self.fail!(response)
    end
  end

  # This is master trigger method
  # Iterates over the pending payments
  def self.prepare_payments
    payments = self.pending
    payments.each do |payment|
      payment.set_ready!
    end
  end

  def self.init_paypal_gateway
    @paypal_gateway ||= ActiveMerchant::Billing::PaypalGateway.new({
      :login => ::PAYPAL_API_USERNAME,
      :password => ::PAYPAL_API_PASS,
      :signature => ::PAYPAL_API_SIGN
    })
  end

  private

  def self.pending#(delay = 48.hours)
    #Get the Payments with state = :ready and has the transaction state :paid
    #payments = self.joins(:transaction => :inquiry).where('payments.state = ?', :scheduled)
    #.where('transactions.state = ?', :paid)
    #.where('inquiries.pay_at <= ?', Time.now - delay)
    self.where(:state => :scheduled).where(["pay_at <= ?", Time.now])
  end

  def log_payment(options={})
    log = self.payment_logs.create(
      :state => options[:to],
      :previous_state => options[:from],
      :additional_data => options[:additional_data]
    )
    log.save
  end

end
