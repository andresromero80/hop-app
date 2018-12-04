class CategoriesController < ApplicationController

	before_action :category_params, only: ['create']

	def category_params
		permitted = params.require(:category).permit(:name)
	end

	def show
		@category = Category.find(params[:id])
	end

	def new
		@category = Category.new
	end

	def create
		permitted = category_params
		@category = Category.create(permitted)
	end
end