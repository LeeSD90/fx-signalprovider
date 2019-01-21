Rails.application.routes.draw do
  root 'landing#new'
  devise_for :users

  match '/landing', to: 'landing#new', via: 'get'
  resources "landing", only: [:new, :create]

  get "/static_pages/:static_page" => "static_pages#show"
end
