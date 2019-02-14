class Subscription < ApplicationRecord
  attr_accessor :paypal_payment_token
  validates :paypal_recurring_profile_token, uniqueness: true

  belongs_to :user
  belongs_to :plan

  enum status: { inactive: 0, active: 1 }

  def paypal
    PaypalPayment.new(self)
  end

  def cancel_with_paypal_payment
    if valid?
      response = paypal.cancel_recurring
      save!
    end
  end

  def save_with_paypal_payment
    if valid? && paypal_payment_token.present?
      response = paypal.make_recurring
      self.paypal_recurring_profile_token = response.profile_id
      save!
    end
  end
end
