Rails.application.routes.draw do

  get 'inventories/show'
   resources :conversations do
    resources :messages
   end

  resources :trades, :products, :categories
  devise_for :users
	root to: "static_pages#index"
end


