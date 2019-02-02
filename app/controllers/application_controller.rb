class ApplicationController < ActionController::Base
  protect_from_forgery with: :exception

  def render_404
    render file: "public/404.html", status: :not_found
  end

  private

    def admin_only
      if !current_user.try(:admin?)
        flash[:error] = 'Admin Access Only.'
        redirect_to root_path
      end
    end
end
