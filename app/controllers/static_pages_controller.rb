class StaticPagesController < ApplicationController
  def index
  	@categories = Category.all
  end
end
