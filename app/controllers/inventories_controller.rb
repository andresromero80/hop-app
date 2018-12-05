class InventoriesController < ApplicationController
  def show
  	@products = @inventory.products
  	# @products.each do |p|
  	# 	p.uploads.each do |u|
  	# 		puts url_for(u)
  	# 	end
  	# end
  end
end
