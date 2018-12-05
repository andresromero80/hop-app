Rails.application.routes.draw do

	root to: "static_pages#index"
  get '/loans/ask/:id_loaner/:id_product', to: 'loans#loan_ask'
  get '/my-inventory', to: 'inventories#show'
  
  resources :conversations do
    resources :messages
  end

  resources :trades, :products, :categories
  devise_for :users, :controllers => { registrations: "users/registrations", sessions: "users/sessions" }
  get '/profile/account', to: 'profile#account'
  get '/profile/loan-requests-pending', to: 'profile#loan_requests_pending'
  get 'messages/index', to: 'messages#index'

  post '/products/search', to: 'searches#search'
end