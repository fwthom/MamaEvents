Rails.application.routes.draw do
  namespace :admin do
      resources :charities
      resources :events
      resources :options
      resources :orders
      resources :participants
      resources :participations
      resources :payments
      resources :teams
      resources :tickets
      resources :users

      root to: "charities#index"
    end

  devise_for :users
  root to: "pages#home"
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  # Reveal health status on /up that returns 200 if the app boots with no exceptions, otherwise 500.
  # Can be used by load balancers and uptime monitors to verify that the app is live.
  get "up" => "rails/health#show", as: :rails_health_check

  # Defines the root path route ("/")
  # root "posts#index"
  resources :participants
end
