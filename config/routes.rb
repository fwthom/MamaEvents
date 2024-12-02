Rails.application.routes.draw do
  namespace :admin do
    resources :options
    resources :participants
    resources :participations
    resources :users
    resources :donations
    resources :payments
    resources :tickets
    resources :events, only: [:new, :create, :index, :edit, :update, :show] do
      resources :options, only: [:new, :create, :index, :edit, :update, :destroy]
      resources :tickets, only: [:new, :create, :index, :edit, :update, :destroy]
    end
    root to: "custom_pages#home"
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

  resources :participations

  resources :events, only: [:index, :show] do
    resources :options, only: [ :index]
    resources :tickets, only: [ :index]
  end




  resources :charities do
    resources :events do
      resources :participants do
        resources :participations
      end
    end
  end

end
