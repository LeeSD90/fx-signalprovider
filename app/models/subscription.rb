class Subscription < ApplicationRecord
  attr_accessor :paypal_payment_token
  validates :paypal_recurring_profile_token, uniqueness: true

  belongs_to :user
  belongs_to :plan

  enum status: { Inactive: 0, Active: 1, Expired: 2 }

  def paypal
    PaypalPayment.new(self)
  end

  def update_billing
    self.next_billing_date = Date.current + (self.plan.duration).month
    save!
  end

  def check_expiry
    self.expire if Date.today > self.expires
  end

  def expire
    self.subscription.status = "Expired"
    save!
  end

  def cancel
    self.expires = self.next_billing_date
    self.next_billing_date = nil
    self.status = "Inactive"
    save!
  end

  def activate
    self.expires = nil
    self.update_billing
    self.status = "Active"
    save!
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
