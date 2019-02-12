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
    end
end
