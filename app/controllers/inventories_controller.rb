class InventoriesController < ApplicationController
  def show
  	@products = @inventory.products
  end
end
