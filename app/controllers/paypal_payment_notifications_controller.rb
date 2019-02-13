class PaypalPaymentNotificationsController < ApplicationController
  protect_from_forgery :except => [:create]

  def create
    response = validate_IPN_notification(request.raw_post)
    case response
    when "VERIFIED"
      ## Do verification stuff
      ## Check txn_types
      ## Take action
      ## Write to file?
      if params[:receiver_email] == ENV['PAYPAL_EMAIL']
        case params[:txn_type]
        when "recurring_payment_profile_cancel"
          subscription = Subscription.where(paypal_recurring_profile_token: params[:recurring_payment_id]).first
          subscription.destroy
        when
        else
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
end
