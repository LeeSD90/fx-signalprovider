class StaticPagesController < ApplicationController
  def show
    render template: "static_pages/#{params[:static_page]}"
  end
end
