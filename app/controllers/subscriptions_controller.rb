class SubscriptionsController < ApplicationController
  before_action :admin_only
  before_action :authenticate_user!, only: [:paypal_checkout]
  
  def new
    @plan = Plan.find_by_id(params[:plan_id])
    redirect_to root_path, :flash => { :error => 'Record not found' } unless @plan

    @subscription = @plan.subscriptions.build
    @subscription.user = current_user

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
