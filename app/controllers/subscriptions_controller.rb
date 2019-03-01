class SubscriptionsController < ApplicationController
  before_action :admin_only
  before_action :authenticate_user!, only: [:paypal_checkout, :show]
  before_action :correct_user, only: [:show, :destroy]
  
  def new
    @plan = Plan.find_by_id(params[:plan_id])
    redirect_to root_path, :flash => { :error => 'Record not found' } unless @plan

    @subscription = @plan.subscriptions.build
    @subscription.user = current_user

    if params[:PayerID]
      @subscription.paypal_customer_token = params[:PayerID]
      @subscription.paypal_payment_token = params[:token]
      @subscription.save_with_paypal_payment
      flash.now[:success] = "You have successfully subscribed to our forex signalling service!"
    end
  end

  def show
    
  end

  def destroy
    @subscription.cancel_with_paypal_payment
    flash[:success] = "You have successfully unsubscribed from our forex signalling service"
    redirect_to root_url
  end

  # TODO, add instruction mail
  def instructions
    if current_user.subscribed? && !current_user.subscription.Expired?
      AdminMailer.admin_mail("User service instruction mail", "Instructions and stuff go here").deliver
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

  private

    def correct_user
      @subscription = current_user.subscription

      if @subscription.nil?
        flash[:error] = "You do not currently have an existing subscription"
        redirect_to signals_path
      end
    end

end
