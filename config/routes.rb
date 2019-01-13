Rails.application.routes.draw do
  root 'landing#new'
  devise_for :users
  match '/landing', to: 'landing#new', via: 'get'
  resources "landing", only: [:new, :create]
end
