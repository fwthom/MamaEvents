Rails.application.routes.draw do
  namespace :admin do
    resources :users
    resources :donations
    resources :payments


    resources :events, only: [:new, :create, :index, :edit, :update, :show] do
      resources :participants, only: [:index, :show, :edit, :update, :destroy]
      resources :participations, only: [:index, :show, :edit, :update, :destroy]
      resources :options, only: [:new, :create, :index, :edit, :update, :destroy]
      resources :tickets, only: [:new, :create, :index, :edit, :update, :destroy]
      member do
        patch 'publish'   # Met à jour le statut de l'évènement
        get 'extract_optn', to: 'documents#download_options_xlsx', as: 'download_options_xlsx'
        get 'extract_bib', to: 'documents#download_bib_numbers_xlsx', as: 'download_bib_numbers_xlsx'
      end
    end

    root to: "custom_pages#home"
    delete '/clear_event', to: 'events#clear_event', as: 'clear_event'
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
  resources :participations, only: [:edit, :update, :show]

  resources :events, only: [:index, :show] do
    resources :participants, only: [:new, :create]
  end

  resources :participants do
    get "token"
  end

  get 'send_email/:token', to: 'participations#send_participation_message', as: :send_email


end
