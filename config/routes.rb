Rails.application.routes.draw do
  devise_for :users, skip: 'password'

  root to: 'users#show'

  get '/prediction', to: 'pages#prediction'

  resources :fish, only: [:index, :show]
  resources :locations, only: [:create]

  resources :logs, except: [:new, :edit] do
    resources :catches, only: [:create, :destroy]
  end

  # API
  namespace :api, defaults: { format: :json } do
    namespace :v1 do
      resources :fish, only: [ :index ]

      resources :users, only: [ :show ] do
        resources :locations, only: [ :index, :show, :create, :update ] do
          resources :logs, only: [ :index, :show ]
        end
      end
    end
  end
end
