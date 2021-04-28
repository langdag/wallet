Rails.application.routes.draw do
  resources :stocks
  resources :teams
  root 'home#index'
  resources :users
  resources :wallets, only: :show
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
end
