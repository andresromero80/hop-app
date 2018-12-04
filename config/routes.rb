Rails.application.routes.draw do

   resources :conversations do
    resources :messages
   end

  resources :trades
  devise_for :users
	root to: "static_pages#index"
end


