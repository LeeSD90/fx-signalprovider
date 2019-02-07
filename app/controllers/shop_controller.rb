class ShopController < ApplicationController
  before_action :admin_only, :set_plans

  private

    def set_plans
      @plans = Plan.all
    end

end
