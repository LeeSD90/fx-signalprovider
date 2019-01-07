Rails.application.routes.draw do
  devise_for :users
  root 'landing#new'
  resources "landing", only: [:new, :create]
end
