class InventoriesController < ApplicationController
  def show
  	@products = []
    @categories = Category.all
  	if !@inventory.products.nil?
  		@products = @inventory.products
  	end
  	# @products.each do |p|
  	# 	p.uploads.each do |u|
  	# 		puts url_for(u)
  	# 	end
  	# end
  end
end
