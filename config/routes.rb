Rails.application.routes.draw do
  root to: "static_pages#index"
  get '/home', to: "static_pages#home"
	
  resources :trades, :categories, :products
  
  resources :conversations do
    resources :messages
  end

  devise_for :users, :controllers => { registrations: "users/registrations", sessions: "users/sessions" }

  # Messages / Conversations
  get 'messages/index', to: 'messages#index'
  get 'conversations', to: 'conversations#index'

  # Products / Inventory / Search
  get '/my-inventory', to: 'inventories#show'
  get '/products-filtered', to: 'products#index_with_filters'

  post '/products-search', to: 'searches#search'

  # Loans
  get '/loans/ask/:id_loaner/:id_product', to: 'loans#loan_ask'
  get '/loan-confirm/:loan_ask_id', to: 'loans#confirm'
  get '/loan-refuse/:loan_ask_id', to: 'loans#refuse'

  # Profile Info / SMS verification
  get '/profile/account', to: 'profile#account'
  get '/profile/loan-requests-pending', to: 'profile#loan_requests_pending'
  get '/profile/my-loan-requests', to: 'profile#my_loan_request'
  get '/profile/archived-loans', to: 'profile#archives'

  get '/profile/ask_profile_verification', to: 'profile#ask_profile_verification'
  get '/profile/cancel_profile_verification/:request_id', to: 'profile#cancel_profile_verification'

  post '/profile/verify_profile', to: 'profile#verify_profile'

  match "/404", :to => "errors#not_found", :via => :all
  match "/500", :to => "errors#internal_server_error", :via => :all

end
