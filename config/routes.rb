Rails.application.routes.draw do
  devise_for :users
  root to: 'users#show'
  get '/prediction', to: 'pages#prediction'

  resources :fish, only: [:index, :show]
  resources :locations

  resources :logs do
    resources :catches, only: [:create, :destroy]
  end
end
