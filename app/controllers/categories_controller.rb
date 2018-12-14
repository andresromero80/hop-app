class CategoriesController < ApplicationController

	before_action :category_params, only: ['create']

	def category_params
		permitted = params.require(:category).permit(:name)
	end

	def index
		@categories = Category.all
		@categories.each do |c|
			if !c.products.empty?
				if !@products
				 @products = c.products.order(:title).page params[:page]
				else
					a =  c.products.order(:title).page params[:page]
					@products << a
				end
			end
		end
		puts @products.class
		render "products/index"
	end

	def show
		@categories = Category.all
		@category = Category.find(params[:id])
		@products = @category.products.order(:title).page params[:page]
		puts @products.class
		render "products/index"
	end

	def new
		@category = Category.new
	end

	def create
		permitted = category_params
		@category = Category.create(permitted)
	end
end