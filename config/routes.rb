Rails.application.routes.draw do
  # get 'messages/index'
  # get 'conversations/index'

   resources :conversations do
    resources :messages
   end

  resources :trades
  devise_for :users
  # get 'static_pages/home'
  # get 'static_pages/index'
	root to: "static_pages#home"
end


