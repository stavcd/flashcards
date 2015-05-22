Rails.application.routes.draw do

  root to: 'home#index'

  post 'oauth/callback', to: 'oauths#callback'

  get 'oauth/callback', to: 'oauths#callback'

  get 'oauth/provider', to: 'oauths#oauth', as: :auth_at_provider

  resources :reviews, only: [:index, :create]

  resources :sessions

  resources :users
  get 'cards/new', to: 'cards#new'

  post 'cards/create', to: 'cards#create'

  resources :decks do

    member do
      put 'set_current'
    end
    resources :cards, shallow: true do
      get 'crop_image', on: :member
      put 'crop_image', on: :member
    end
  end

  resources :cards do
    get 'crop_image', on: :member
    put 'crop_image', on: :member
  end

  get 'profile', to: 'profile#edit'

  post 'profile', to: 'profile#update'

  get 'login', to: 'sessions#new'

  post 'logout', to: 'sessions#destroy'
end
