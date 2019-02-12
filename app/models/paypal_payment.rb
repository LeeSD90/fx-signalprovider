class PaypalPayment

  def initialize(subscription)
    @subscription = subscription
  end

  def checkout_details
    PayPal::Recurring.new(token: @subscription.paypal_payment_token).checkout_details
  end

  def checkout_url(options)
    process(:checkout, options).checkout_url
  end

  def cancel_recurring
    process :cancel
  end

  def make_recurring
    process :request_payment
    process :create_recurring_profile, period: @subscription.plan.interval, frequency: @subscription.plan.duration, start_at: Time.zone.now
  end

  private

    def process(action, options = {})
      options = options.reverse_merge(
        token: @subscription.paypal_payment_token,
        payer_id: @subscription.paypal_customer_token,
        description: @subscription.plan.name,
        amount: @subscription.plan.price,
        currency: @subscription.plan.currency,
        ipn_url: "https://fx-signalprovider.com/paypal_payment_notifications"
      )

      response = PayPal::Recurring.new(options).send(action)
      raise response.errors.inspect if response.errors.present?
      response
    end

end