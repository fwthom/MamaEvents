Rails.application.routes.draw do
  namespace :admin do
    resources :options
    resources :participants
    resources :participations
    resources :users
    resources :donations
    resources :payments
    root to: "users#index"
  end

  root to: "pages#home"

  devise_for :users

  resources :donations, only: [:new, :create]
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

  resources :options, only: [:new, :create, :edit, :update, :destroy]
  resources :events, only: [:new, :create, :index, :edit, :update, :show] do
    resources :tickets
  end

end
