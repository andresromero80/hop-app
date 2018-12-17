class StaticPagesController < ApplicationController

  def index
  	@categories = Category.all
  	@icon_list = ["fa fa-users", "fa fa-film", "fa fa-briefcase", 
  				"fa fa-wrench", "fa fa-cutlery", "fa fa-music"]
  end
end
