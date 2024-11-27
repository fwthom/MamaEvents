Rails.application.routes.draw do
  namespace :admin do
    resources :options
    resources :participants
    resources :participations
    resources :users
    root to: "users#index"
  end

  root to: "pages#home"

  devise_for :users

  resources :payments, only: [:new, :create] do
    collection do
      get :success
    end
  end

  # Reveal health status on /up that returns 200 if the app boots with no exceptions, otherwise 500.
  # Can be used by load balancers and uptime monitors to verify that the app is live.
  get "up" => "rails/health#show", as: :rails_health_check

  # Defines the root path route ("/")
  # root "posts#index"

  resources :participants

  resources :tickets

  resources :events, only: [:new, :index, :create, :show] do
    resources :options, only: [:new, :index, :create, :show]
  end

end
