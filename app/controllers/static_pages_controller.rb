class StaticPagesController < ApplicationController
  before_action :admin_only

  def show
    if template_exists?("#{params[:static_page]}", _prefixes)
      render template: "static_pages/#{params[:static_page]}"
    else
      render file: "#{Rails.root}/public/404", status: :not_found
    end
  end
end
