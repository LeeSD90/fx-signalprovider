Rails.application.routes.draw do
  root 'landing#new'
  resources :landing, only: [:new, :create]
  resources :subscriptions, only: :new
  devise_for :users

  get "paypal/checkout", to: "subscriptions#paypal_checkout"
  get "/:static_page" => "static_pages#show", :as => "static_page"
  get '*path' => "application#render_404"
end
