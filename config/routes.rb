Rails.application.routes.draw do
  resources :trades
  devise_for :users
  # get 'static_pages/home'
  # get 'static_pages/index'
	root to: "static_pages#home"
end
