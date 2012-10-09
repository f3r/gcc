class Transaction < ActiveRecord::Base
  include Workflow

  belongs_to :user
  belongs_to :inquiry
  has_many :transaction_logs, :dependent => :destroy

  before_create :set_transaction_code

  validates_presence_of :check_in, :user_id, :state, :message => "101"
  validates_date :check_in,  :after => :today,          :invalid_date_message => "113", :after_message => "119"
  #validates_date :check_out, :on_or_after => :check_in, :invalid_date_message => "113", :on_or_after_message => "120"
  #validate :check_min_max_stay

  workflow_column :state

  workflow do
    state :requested do
      event :pre_approve,     :transitions_to => :ready_to_pay
      event :decline,         :transitions_to => :declined
    end
    state :ready_to_pay do
      event :cancel,          :transitions_to => :cancelled
      event :pay,             :transitions_to => :paid
    end
    state :paid
    state :cancelled
    state :declined

    # Check user permissions before every transition
    before_transition do |from, to, triggering_event, *event_args|
      halt! unless permitted_to?(triggering_event)
    end

    # After transition: log transactions, send system msgs and notification emails to renter and owner
    after_transition do |from, to, triggering_event, *event_args|
      log_transaction(:from => from, :to => to, :triggering_event => triggering_event, :additional_data => event_args[0])
      event = triggering_event.to_sym
      self.add_system_message(event)
      TransactionMailer.mail_dispatcher(event, self.inquiry)
    end
  end

  def change_state!(event)
    events = self.current_state.events.keys
    if events.include?(event.to_sym)
      self.send("#{event}!")
    end
  end

  # Special method for handling paypal payment, in the future in can log more details about the transfer
  def received_payment!(params)
    self.pay!(params)
  end

  def add_system_message(msg_id)
    c = self.inquiry.conversation
    Messenger.add_system_message(c.id, msg_id) if c
  end

  def product
    self.inquiry.product
  end

  def name
    "##{self.id}"
  end

  def code
    self.transaction_code
  end

  def zero_with_currency
    0.to_money(Currency.default.currency_code)
  end

  def total_amount
    self.product_amount + self.fee_amount
  end

  def amount_display(amount)
    "<span class='iso-code'>#{amount.currency.iso_code}</span> #{amount.currency.symbol}#{amount.to_f}".html_safe
  end

  # Total amount string with the currency symbol
  def total_amount_display
    amount_display(self.total_amount)
  end

  def product_amount_display
    amount_display(self.product_amount)
  end

  def fee_amount_display
    amount_display(self.fee_amount)
  end

  def rate_display
    amount, unit = self.inquiry.rate
    "#{amount_display(amount)} #{I18n.t(unit).downcase}"
  end

  def product_amount
    SiteConfig.charge_total ? self.inquiry.price : zero_with_currency
  end

  def fee_amount
    if SiteConfig.fee_is_fixed
      SiteConfig.fee_amount.to_money(Currency.default.currency_code)
    else
      self.inquiry.price * SiteConfig.fee_amount / 100.0
    end
  end

  def price(a_currency = nil)
    a_currency ||= Currency.default
    unit = case self.inquiry.length_stay_type.to_sym
      when :hours
        :per_hour
      when :days
        :per_day
      when :weeks
        :per_week
      when :months
        :per_month
      end
    self.product.money_price(unit, a_currency) * self.inquiry.length_stay
  end

  def fee_description
    SiteConfig.fee_is_fixed ? "Service fee" : "#{SiteConfig.fee_amount}% service fee"
  end

private

  def generate_transaction_code
    # date + 4 random characters, 1 679 616 posible codes per day.
    transaction_code = Time.now.strftime("%y-%m%d-#{rand(36**4).to_s(36).upcase}")

    if Transaction.exists?(:transaction_code => transaction_code)
      self.generate_transaction_code
    else
      transaction_code
    end
  end

  def set_transaction_code
    self.transaction_code = generate_transaction_code
  end

  def log_transaction(options={})
    log = self.transaction_logs.create(
      :state => options[:to],
      :previous_state => options[:from],
      :additional_data => options[:additional_data]
    )
    log.save
  end

  # def check_min_max_stay
  #   return true
  #   check_in = self.check_in.to_date
  #   check_out = self.check_out.to_date
  #   total_days = (check_in..check_out).to_a.count

  #   if self.place && !self.place.stay_unit.blank?
  #     min_stay = self.place.minimum_stay.send(self.place.stay_unit)
  #     max_stay = self.place.maximum_stay.send(self.place.stay_unit)
  #     days = total_days.days

  #     unless days >= min_stay or min_stay == 0
  #       errors.add(:check_out, "141") # minimum stay not met
  #     end

  #     unless days <= max_stay or max_stay == 0
  #       errors.add(:check_out, "142") # over maximum stay
  #     end
  #   end
  # end
end