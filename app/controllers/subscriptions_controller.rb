class SubscriptionsController < ApplicationController
  before_action :admin_only
  
  def new
    @subscription = Subscription.new
  end

  def paypal_checkout
  end
end
