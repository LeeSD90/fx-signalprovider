class LandingController < ApplicationController
  layout 'landing'

  def new
    @landing = Landing.new
  end

  def create
    @landing = Landing.new(params[:landing])
    @landing.request = request
    if @landing.deliver
      flash.now[:notice] = 'Thank you for signing up, we will contact you soon.'
    else
      flash.now[:error] = 'Error signing up.'
      render :new
    end
  end
end
