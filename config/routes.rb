Rails.application.routes.draw do
  devise_for :users
  root to: 'users#show'

  resources :fish, only: [:index]
  resources :locations
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
  
  resources :logs do
    resources :catches, only: [:create, :destroy]
  end
end
