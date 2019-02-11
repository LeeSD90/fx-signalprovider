class Subscription < ApplicationRecord
  attr_accessor :paypal_payment_token

  belongs_to :user
  belongs_to :plan

  def save_with_paypal_payment
    ppr = PayPal::Recurring.new(
      token: paypal_payment_token,
      payer_id: paypal_customer_token,
      description: plan.name,
      amount: plan.price,
      currency: plan.currency
    )

    response = ppr.request_payment

    if response.errors.present?
      raise response.errors.inspect
    end
  end
end
