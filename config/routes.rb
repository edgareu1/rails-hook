Rails.application.routes.draw do
  devise_for :users
  root to: 'pages#home'
  
  resources :logs do
    resources :catches, only: [:create]
  end
end
