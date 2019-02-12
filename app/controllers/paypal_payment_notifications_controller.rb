class PaypalPaymentNotificationsController < ApplicationController
  def create
    response = validate_IPN_notification(request.raw_post)

    case response
    when "VERIFIED"
      puts response.inspect
    when "INVALID"
      puts response.inspect
    else
      #error
    end

    render :nothing => true
  end

  protected

    def validate_IPN_notification(raw)
      uri = URI.parse('https://ipnpb.sandbox.paypal.com/cgi-bin/webscr')
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
