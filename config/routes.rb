Rails.application.routes.draw do
  devise_for :users, skip: 'password'

  root to: 'users#show'

  get '/prediction', to: 'pages#prediction'

  resources :fish,      only: [ :index, :show ]
  resources :locations, only: [ :index, :show, :create, :update, :destroy ]

  resources :logs, only: [ :index, :show, :create, :update, :destroy ] do
    resources :catches, only: [ :create, :destroy ]
  end

  # API
  namespace :api, defaults: { format: :json } do
    namespace :v1 do
      resources :fish, only: [ :index, :show ]
      get '/users/:user_id', to: 'users#show'

      scope '/users/:user_id' do
        get '/prediction(/:num)', to: 'pages#top_prediction'

        resources :locations, only: [ :index, :show, :create, :update, :destroy ] do
          get '/prediction', to: 'pages#location_prediction'
          get '/logs',       to: 'logs#location_index'
        end

        resources :logs, only: [ :index, :show, :create, :update, :destroy ] do
          resources :catches, only: [ :index, :create, :destroy ]
        end
      end
    end
  end
end
