class Subscription < ApplicationRecord
  attr_accessor :paypal_payment_token

  belongs_to :user
  belongs_to :plan

  def paypal
    PaypalPayment.new(self)
  end

  def save_with_paypal_payment
    response = paypal.make_recurring
    self.paypal_recurring_profile_token = response.profile_id
    save!
  end
end
