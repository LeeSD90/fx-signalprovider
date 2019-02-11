class SubscriptionsController < ApplicationController
  before_action :admin_only
  
  def new
    @subscription = Subscription.new
    @plan = Plan.find_by_id(params[:plan])

    redirect_to root_path, :flash => { :error => 'Record not found' } unless @plan
  end

  def paypal_checkout
    plan = Plan.find(params[:plan_id])
    ppr = Paypal::Recurring.new(
      return_url: new_subscription_path(:plan_id => plan.id),
      cancel_url: root_path,
      description: plan.name,
      amount: plan.price,
      currency: plan.currency 
    )

    response = ppr.checkout

    if response.valid?
      redirect_to response.checkout_url
    else
      rais response.errors.inspect
    end
  end

end
