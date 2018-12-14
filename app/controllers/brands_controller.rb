class BrandsController < ApplicationController

	def brand_params
		params.require[:brand].permit(:name)
	end

	def create
		@permitted = brand_params
		Brand.create(@permitted)
	end
end
