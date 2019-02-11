class Subscription < ApplicationRecord
  attr_accessor :paypal_payment_token

  belongs_to :user
  belongs_to :plan
end
