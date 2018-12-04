class ProductsController < ApplicationController
	before_action : product_param

	def product_param
		permitted = params.require(:product).permit(:short_desc, :long_desc, :brand, :state)
	end
	def new
		@states = [
			"neuf",
			"en bon état",
			"abimé"
		]
		@product = Product.new
	end

	def create
		permitted = product_param
		permitted[:inventory_id] = Inventory.find_by(user_id: current_user.id).pluck('id')
		@product = Product.create(permitted)
	end
end