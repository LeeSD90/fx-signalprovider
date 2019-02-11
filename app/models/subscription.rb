class Subscription < ApplicationRecord
  attr_accessor :paypal_payment_token

  belongs_to :user
  belongs_to :plan

  def paypal
    PaypalPayment.new(self)
  end

  def save_with_paypal_payment
    paypal.make_recurring
  end
end
