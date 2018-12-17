class CategoriesController < ApplicationController

	before_action :category_params, only: ['create']

	def category_params
		permitted = params.require(:category).permit(:name)
	end

	def index
		@categories = Category.all

		@categories.each do |c|
			if !c.products.empty?
				if !@ids
			 		@ids = c.products.distinct.pluck('id').flatten
			 	else
			 		@ids << c.products.distinct.pluck('id').flatten
			 	end
			end
		end
		@ids.flatten.inspect
		@products = Product.where(id: @ids).order(:title).page params[:page]

		@icon_list = ["fa fa-users", "fa fa-film", "fa fa-briefcase", 
  				"fa fa-wrench", "fa fa-cutlery", "fa fa-music"]


		render "products/index"
	end

	def show
		@categories = Category.all
		@category = Category.find(params[:id])
		@products = @category.products.distinct.order(:title).page params[:page]
		
		@icon_list = ["fa fa-users", "fa fa-film", "fa fa-briefcase", 
  				"fa fa-wrench", "fa fa-cutlery", "fa fa-music"]

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