class ProductsController < ApplicationController
	before_action :product_param, only: ['create', 'update']
	before_action :product_detail_param, only: ['create', 'update']
	before_action :categories_param, only: ['create', 'update']
	before_action :authenticate_user!

	def product_param
		permited = params.require(:product).permit(:title, :short_desc, :long_desc, :state, uploads: [])
		permited[:inventory_id] = Inventory.find_by(user_id: current_user.id).id
		permited
	end

	def product_detail_param
		d = params.require(:product).permit(:product_detail => [:name])[:product_detail]
		puts d.class
		puts d.inspect
		d
	end

	def categories_param
		params.require(:product).permit(categories: [])[:categories]
	end
	def index
		@categories = Category.all
		ids = Product.where(inventory_id: Inventory.find_by(user_id: current_user.id)).pluck('id');

		(ids << Loan.where(borrower_id: current_user.id, back_ask: nil).pluck('product_id')).flatten!

		@products = Product.where.not(id: ids).order(:title).page params[:page]
	end

	def index_with_filters
		@categories = Category.all

		# ids = Product.where(inventory_id: Inventory.find_by(user_id: current_user.id)).pluck('id');

		# (ids << Loan.where(borrower_id: current_user.id, back_ask: nil).pluck('product_id')).flatten!

		# params[:product_id].each do |i|
		# 	ids.delete(i)
		# end

		# @products = Product.where(id: ids)
		@products = params[:product_id]
		render "index"
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
		@p = product_param
		@d = product_detail_param
		@c = categories_param

		@product = Product.create(@p)
		Brand.create(@d)

		if !@c.nil? 
			@c.each do |c|
				c = c.to_i
				unless c <= 0
					@product.categories << Category.find(c)
				end
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
		puts @permitted
		@product = Product.update(product_param)
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
		@review = Review.new
		@loan = Loan.new
	end
end