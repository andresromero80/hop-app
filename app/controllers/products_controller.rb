class ProductsController < ApplicationController
	before_action :product_param, only: ['create']

	def product_param
		permitted = params.require(:product).permit(:short_desc, :long_desc, :brand, :state, uploads: [])
	end

	def show
		@product = Product.find(params[:id])
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
		permitted[:inventory_id] = Inventory.find_by(user_id: current_user.id).id
		permitted[:available] = true
		@product = Product.create(permitted)
	end
end