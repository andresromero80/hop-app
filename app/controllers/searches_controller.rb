class SearchesController < ApplicationController
	before_action :search_params, only: ['search']

	def search_params
		params.require('search').permit(:category, :location, :keyword)
	end

	def search
		permitted = search_params
		puts permitted
	end
end