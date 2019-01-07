Rails.application.routes.draw do
  devise_for :users
  root 'landing#new'
  match '/landing', to: 'landing#new', via: 'get'
  resources "landing", only: [:new, :create]
end
