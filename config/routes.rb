Rails.application.routes.draw do
  resources :stocks
  resources :teams
  root 'home#index'
  resources :users
  resources :wallets, only: :show do
    get '/new/deposit', to: 'wallets#new_deposit'
    get '/new/withdraw', to: 'wallets#new_withdraw'
    get '/new/transfer', to: 'wallets#new_transfer'
    post 'deposit', to: 'wallets#deposit'
    post 'withdraw', to: 'wallets#withdraw'
    post 'transfer', to: 'wallets#transfer'
  end
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
end
