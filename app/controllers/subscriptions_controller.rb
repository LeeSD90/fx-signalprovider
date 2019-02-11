class SubscriptionsController < ApplicationController
  before_action :admin_only
  
  def new
    @plan = Plan.find_by_id(params[:plan_id])
    @subscription = @plan.subscriptions.build

    redirect_to root_path, :flash => { :error => 'Record not found' } unless @plan

    if params[:PayerID]
      @subscription.paypal_customer_token = params[:PayerID]
      @subscription.paypal_payment_token = params[:token]
      @subscription.save_with_paypal_payment
    end
  end

  def paypal_checkout
    plan = Plan.find(params[:plan_id])
    subscription = plan.subscriptions.build
    redirect_to subscription.paypal.checkout_url(
      return_url: new_subscription_url(:plan_id => plan.id),
      cancel_url: root_url
    )
  end

end
