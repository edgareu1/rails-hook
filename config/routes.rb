Rails.application.routes.draw do
  devise_for :users, skip: 'password'

  root to: 'users#show'

  get '/prediction', to: 'pages#prediction'

  resources :fish, only: [ :index, :show ]
  resources :locations, only: [ :index, :show, :create, :update, :destroy ]

  resources :logs, except: [ :new, :edit ] do
    resources :catches, only: [ :create, :destroy ]
  end

  # API
  namespace :api, defaults: { format: :json } do
    namespace :v1 do
      resources :fish, only: [ :index, :show ]

      resources :users, only: [ :show ] do
        get '/prediction(/:num)', to: 'pages#top_prediction'

        resources :locations, only: [ :index, :show, :create, :update, :destroy ] do
          resources :logs, only: [ :index, :show, :create, :update, :destroy ]

          get '/prediction', to: 'pages#location_prediction'
        end
      end
    end
  end
end
