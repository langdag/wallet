Rails.application.routes.draw do
  resources :stocks
  resources :teams
  root 'home#index'
  resources :users
  resources :wallets, only: :show do
    post '/deposit', to: 'wallets#new_deposit'
    post '/withdraw', to: 'wallets#new_withdraw'
    post '/transfer', to: 'wallets#new_transfer'
  end
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
end
