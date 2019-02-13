Rails.application.routes.draw do
  root 'landing#new'
  resources :landing, only: [:new, :create]
  resources :subscriptions, only: :new
  resources :paypal_payment_notifications, only: :create
  devise_for :users

  get '/unsubscribe', to: "subscriptions#destroy"
  get "/subscription", to: "subscriptions#show"
  get "/signals", to: "shop#signals"
  get "/services", to: "shop#services"
  get "paypal/checkout", to: "subscriptions#paypal_checkout"
  get "/:static_page" => "static_pages#show", :as => "static_page"
  get '*path' => "application#render_404"
end
