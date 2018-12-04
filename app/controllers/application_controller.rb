class ApplicationController < ActionController::Base

	before_action :configure_permitted_parameters, if: :devise_controller?
	protect_from_forgery with: :exception
	before_action :set_inventory

	def set_inventory
		if current_user
			@inventory = Inventory.find_by(user_id: current_user.id)
			unless @inventory
				@inventory = Inventory.create(user_id: current_user.id, slug: 'mon-panier')
				current_user.cart = @inventory
				@inventory = Inventory.find_by(user_id: current_user.id)
			end
		end
	end
end