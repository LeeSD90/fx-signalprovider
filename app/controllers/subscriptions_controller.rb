class SubscriptionsController < ApplicationController
  before_action :admin_only
  
  def new
    @subscription = Subscription.new
    @plan = Plan.find_by_id(params[:plan])

    redirect_to root_path, :flash => { :error => 'Record not found' } unless @plan
  end

  def paypal_checkout
  end

end
