class ApplicationController < ActionController::Base

	before_action :configure_permitted_parameters, if: :devise_controller?
	protect_from_forgery with: :exception
	before_action :set_inventory

	protected
		def configure_permitted_parameters
	  	devise_parameter_sanitizer.permit(:sign_up, keys:[:header_image])	
		end

	def set_inventory
		if current_user
			@inventory = Inventory.find_by(user_id: current_user.id)
			unless @inventory
				@inventory = Inventory.create(user_id: current_user.id)
				current_user.inventory = @inventory
				@inventory = Inventory.find_by(user_id: current_user.id)
			end
		end
	end
end