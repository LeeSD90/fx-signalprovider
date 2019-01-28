class StaticPagesController < ApplicationController
  before_action :admin_only

  def show
    render template: "static_pages/#{params[:static_page]}"
  end
end
