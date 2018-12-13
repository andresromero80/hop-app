class ProductsController < ApplicationController
	before_action :product_param, only: ['create', 'update']
	before_action :authenticate_user!

	def index
		@categories = Category.all
		@products = Product.all.order(:title).page params[:page]
	end

	def index_with_filters
		@categories = Category.all
		@products = Product.where(id: params[:product_id])
		render "index"
	end
	
	def product_param
		params.require(:product).permit(:title, :short_desc, :long_desc, :brand, :state, uploads: [])
	end

	def new
		@brands = [
			"thompson",
			"sony"
		]
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

	def edit
		@brands = [
			"thompson",
			"sony"
		]
		@states = [
			"neuf",
			"en bon état",
			"abimé"
		]
		@categories = Category.all
		@product = Product.find(params[:id])
	end

	def update
		@permitted = product_param
		puts @permitted
		@product = Product.update(params[:id], @permitted)
		@categories = params.require(:product).permit(categories: [])[:categories]

		@categories.each do |c|
			c = c.to_i
			unless c <= 0
				@product.categories << Category.find(c)
			end
		end
		
		redirect_to '/my-inventory'
	end

	def show
		@product = Product.find(params[:id])
		@inventory = Inventory.find(@product.inventory_id)
		@user = User.find(@inventory.user_id)
		@users = User.all
		@conversations = Conversation.all
	end
end