class ApplicationController < ActionController::Base

	protect_from_forgery with: :exception
	before_action :set_inventory

	protected

	def set_inventory
		if current_user
			@inventory = Inventory.find_by(user_id: current_user.id)
			unless @inventory
				@inventory = Inventory.create(user_id: current_user.id)
				@inventory = Inventory.find_by(user_id: current_user.id)
			end
		end
	end
end