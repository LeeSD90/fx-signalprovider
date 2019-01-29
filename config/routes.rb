Rails.application.routes.draw do
  root 'landing#new'
  resources "landing", only: [:new, :create]

  devise_for :users

  get "/:static_page" => "static_pages#show"

  get '*path' => "application#render_404"
end
