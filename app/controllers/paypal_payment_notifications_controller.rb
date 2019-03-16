class PaypalPaymentNotificationsController < ApplicationController
  protect_from_forgery :except => [:create]

  def create
    response = validate_IPN_notification(request.raw_post)
    case response
    when "VERIFIED"
      ## Do verification stuff
      ## CHECK TXN_ID IS NOT PREVIOUSLY PROCESSED
      ## Take action
      ## Write to file?
      if params[:receiver_email] == ENV['PAYPAL_EMAIL']
        case params[:txn_type]
        when "recurring_payment_profile_created"
            # Profile created, recurring_payment follows shortly. Send instruction mail here?
        when "express_checkout"
          if params[:payment_status] == "Completed"
            # Initial new subscription checkout payment
          end
        when "recurring_payment"
          if params[:payment_status] == "Completed"
            # Payment recieved. Send notification of payment & next billing date?
            subscription = get_subscription(params[:recurring_payment_id])
            if !subscription.nil?
              subscription.activate
            else

            end
          end
        when "recurring_payment_profile_cancel",
             "recurring_payment_expired",
             "recurring_payment_failed",
             "recurring_payment_suspended",
             "recurring_payment_skipped",
             "recurring_payment_suspended_due_to_max_failed_payment"
          subscription = get_subscription(params[:recurring_payment_id])
          if !subscription.nil?
            # Send cancel email
            subscription.cancel
          else

          end
        else
          # Unhandled txn_type
          # Log/Mail admin?
          ApplicationMailer.admin_mail("Unhandled TXN_TYPE", "Params - " + params.inspect).deliver
        end
      end
    when "INVALID"
      ## Write to file?
      ApplicationMailer.admin_mail("Invalid IPN response", "Response - " + response + "\nParams - " + params.inspect).deliver
    else
      # Error
      ApplicationMailer.admin_mail("IPN Error", "Response - " + response + "\nParams - " + params.inspect).deliver
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
