class StaticPagesController < ApplicationController
	include SearchService

  def index
  	@search = SearchService
  	@categories = Category.all
  end
end
