Rails.application.routes.draw do
  devise_for :users, skip: 'password'

  root to: 'users#show'

  get '/prediction', to: 'pages#prediction'

  resources :fish, only: [:index, :show]
  resources :locations, only: [:create]

  resources :logs, except: [:new, :edit] do
    resources :catches, only: [:create, :destroy]
  end
end
