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
				 @products = c.products.distinct.order(:title).page params[:page]
				else
					a =  c.products.distinct.order(:title).page params[:page]
					@products << a
				end
			end
		end

		render "products/index"
	end

	def show
		@categories = Category.all
		@category = Category.find(params[:id])
		@products = @category.products.distinct.order(:title).page params[:page]
		
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