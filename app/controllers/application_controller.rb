class ApplicationController < ActionController::Base

	protect_from_forgery with: :exception
	before_action :set_inventory

	def render_not_found
    render :file => "#{Rails.root}/path/error/404.html", layout: false, status: :not_found
  	end

  	def show
    return not_found if some_condition
  	end

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