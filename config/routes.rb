Rails.application.routes.draw do

	root to: "static_pages#index"
  get '/loans/ask/:id_loaner/:id_product', to: 'loans#loan_ask'
  get 'inventories/show'
  
  resources :conversations do
    resources :messages
  end

  resources :trades, :products, :categories
  devise_for :users, :controllers => { registrations: "users/registrations", sessions: "users/sessions" }
  root to: "static_pages#index"
  get '/customer/signup'
  get '/customer/login'
  get '/profile/account', to: 'profile#account'
  get 'messages/index', to: 'messages#index'
end

