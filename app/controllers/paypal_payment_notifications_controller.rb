class PaypalPaymentNotificationsController < ApplicationController
  protect_from_forgery :except => [:create]

  def create
    response = validate_IPN_notification(request.raw_post)
    case response
    when "VERIFIED"
      ## Do verification stuff
      ## Check txn_types
      ## CHECK TXN_ID IS NOT PREVIOUSLY PROCESSED
      ## Take action
      ## Write to file?
      if params[:receiver_email] == ENV['PAYPAL_EMAIL']
        case params[:txn_type]
        when "express_checkout"
          if params[:payment_status] == "Completed"
            # Initial checkout
            # Send instructions for using the service?
          end
        when "recurring_payment"
          if params[:payment_status] == "Completed"
            # Payment recieved. Send notification of payment & next billing date?
            # Update Subscription with next billing date
            subscription = get_subscription(params[:recurring_payment_id])
            subscription.update_billing
          end
        when "recurring_payment_profile_created"
          # Verify that subscription exists?
          subscription = get_subscription(params[:recurring_payment_id])
          subscription.save
        when "recurring_payment_profile_cancel"
          # Verify that subscription exists?
          subscription = get_subscription(params[:recurring_payment_id])
          subscription.cancel
        when "recurring_payment_expired"
        when "recurring_payment_failed"
        when "recurring_payment_suspended"
        when "recurring_payment_skipped"
        when "recurring_payment_suspended_due_to_max_failed_payment"
        else
          # Unhandled txn_type
          # Log/Mail admin?
        end
      end
    when "INVALID"
      ## Write to file?
      puts "Invalid response from IPN validator!"
    else
      puts "Error!"
      #error
    end

    head :ok
  end

  protected

    def validate_IPN_notification(raw)
      uri = URI.parse('https://www.sandbox.paypal.com/cgi-bin/webscr?cmd=_notify-validate')
      http = Net::HTTP.new(uri.host, uri.port)
      http.open_timeout = 60
      http.read_timeout = 60
      http.verify_mode = OpenSSL::SSL::VERIFY_PEER
      http.use_ssl = true
      response = http.post(
        uri.request_uri,
        raw,
        'Content-Length' => "#{raw.size}",
        'User-Agent' => "Custom User Agent"
      ).body
    end

    def get_subscription(token)
      Subscription.where(paypal_recurring_profile_token: token).first
    end
end
