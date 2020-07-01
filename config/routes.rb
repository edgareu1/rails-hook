Rails.application.routes.draw do
  devise_for :users
  root to: 'pages#home'

  resources :logs
  resources :fish, only: [:index]
  resources :locations
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
end
