class InventoriesController < ApplicationController
  def show
  	@inventory = Inventory.find_by(user_id: current_user.id)
  end
end
