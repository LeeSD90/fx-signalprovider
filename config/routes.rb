Rails.application.routes.draw do
  root 'landing#new'
  resources "landing", only: [:new, :create]

  devise_for :users
  get '*path' => "application#render_404"
  get "/:static_page" => "static_pages#show", :as => "static_page"

end
