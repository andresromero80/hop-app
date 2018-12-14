Rails.application.routes.draw do
  get 'reviews/create'
  get 'errors/not_found'
  get 'errors/internal_server_error'

  root to: "static_pages#index"
  get '/home', to: "static_pages#home"
	
  resources :trades, :categories, :products, :reviews
  
  resources :conversations do
    resources :messages
  end

  devise_for :users, :controllers => { registrations: "users/registrations", sessions: "users/sessions", passwords: "users/passwords" }

  # Messages / Conversations
  get 'messages/index', to: 'messages#index'
  get 'conversations', to: 'conversations#messages/index'

  # Products / Inventory / Search
  get '/my-inventory', to: 'inventories#show'
  get '/products-filtered', to: 'products#index_with_filters'

  post '/products-search', to: 'searches#search'

  # Loans
  post '/loans/ask', to: 'loans#ask'
  get '/loans/ask/cancel/:loan_id', to: 'loans#ask_cancel'
  get '/loans/ask/confirm/:loan_id', to: 'loans#ask_confirm'
  get '/loans/ask/refuse/:loan_id', to: 'loans#ask_refuse'

  get '/loans/back/ask/:loan_id', to: 'loans#back_ask'
  get '/loans/back/confirm/:loan_id', to: 'loans#back_confirm'
  get '/loans/back/refuse/:loan_id', to: 'loans#back_refuse'

  # Profile Info / SMS verification
  get '/profile/account', to: 'profile#account'

  get '/profile/requests-pending', to: 'profile#requests_pending'
  get '/profile/requests-current', to: 'profile#requests_current'
  get '/profile/requests-past', to: 'profile#requests_past'

  get '/profile/asks', to: 'profile#asks'
  get '/profile/asks-pending', to: 'profile#asks_pending'
  get '/profile/asks-current', to: 'profile#asks_current'
  get '/profile/asks-past', to: 'profile#asks_past'

  get '/profile/ask_profile_verification', to: 'profile#ask_profile_verification'
  get '/profile/cancel_profile_verification/:request_id', to: 'profile#cancel_profile_verification'

  post '/profile/verify_profile', to: 'profile#verify_profile'
  get '/profile/close', to: 'profile#close'

  #error views 
  match "/404", :to => "errors#not_found", :via => :all
  match "/500", :to => "errors#internal_server_error", :via => :all
end