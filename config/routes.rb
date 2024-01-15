Rails.application.routes.draw do
  devise_for :users
  root to: 'posts#index'
  resources :items,only: [:index, :new, :create]
end
