class ProductsController < ApplicationController
	before_action :product_param, only: ['create']

	def index
	end
	
	def product_param
		params.require(:product).permit(:title, :short_desc, :long_desc, :brand, :state, uploads: [])
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

		@categories = Category.all
		@product = Product.new
	end

	def create
		@permitted = product_param
		@permitted[:inventory_id] = Inventory.find_by(user_id: current_user.id).id
		@permitted[:available] = true
		@product = Product.create(@permitted)

		@categories = params.require(:product).permit(categories: [])[:categories]
		@categories.each do |c|
			c = c.to_i
			unless c <= 0
				@product.categories << Category.find(c)
			end
		end

		redirect_to '/my-inventory'
	end
end