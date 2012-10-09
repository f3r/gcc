require 'money/bank/google_currency'
Money.default_bank = Money::Bank::GoogleCurrency.new

class Currency < ActiveRecord::Base
  default_scope :order => 'currency_code ASC'

  validates_presence_of :name
  validates_presence_of :symbol

  scope :active,    where("active")
  scope :inactive,  where("not active")

  def self.default
    self.first
  end

  def label
    "#{self.currency_code} #{self.symbol}"
  end

  def usd?
    self.currency_code == 'USD'
  end

  def from_usd(amount_usd)
    amount_usd.to_money('USD').exchange_to(self.currency_code).to_f.to_i
  end

  def to_usd(amount)
    amount.to_money(self.currency_code).exchange_to('USD').to_f.to_i
  end

  def activate!
    self.active = true
    self.save
  end

  def deactivate!
    self.active = false
    self.save
  end

end