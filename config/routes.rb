Rails.application.routes.draw do

  get 'inventories/show'
   resources :conversations do
    resources :messages
   end

  resources :trades, :products, :categories
  devise_for :users
  root to: "static_pages#index"
  get '/customer/signup'
  get '/customer/login'
  get '/profile/account', to: 'profile#account'
  get 'messages/index', to: 'messages#index'
end


