Rails.application.routes.draw do
  get 'customer/signup'
  get 'customer/login'
  # get 'messages/index'
  # get 'conversations/index'

   resources :conversations do
    resources :messages
   end

  resources :trades
  devise_for :users
  # get 'static_pages/home'
  # get 'static_pages/index'
	root to: "static_pages#index"
end


