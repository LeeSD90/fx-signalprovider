class ShopController < ApplicationController
  before_action :admin_only

  def services
    @plans = Plan.all
  end

  def signals
    @plans = Plan.all
  end
end
