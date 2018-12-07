Rails.application.routes.draw do

	root to: "static_pages#index"
  get '/loans/ask/:id_loaner/:id_product', to: 'loans#loan_ask'
  get '/loan-confirm/:loan_ask_id', to: 'loans#confirm'
  get '/loan-refuse/:loan_ask_id', to: 'loans#refuse'
  get '/my-inventory', to: 'inventories#show'
  
  resources :conversations do
      resources :messages
    end

  resources :trades, :categories, :products
  devise_for :users, :controllers => { registrations: "users/registrations", sessions: "users/sessions" }
  get '/profile/account', to: 'profile#account'
  get '/profile/loan-requests-pending', to: 'profile#loan_requests_pending'
  get '/profile/my-loan-requests', to: 'profile#my_loan_request'
  get '/profile/archived-loans', to: 'profile#archives'
  get 'messages/index', to: 'messages#index'

  post '/products/search', to: 'searches#search'

  get 'conversations', to: 'conversations#index'
end