class SearchesController < ApplicationController

	before_action :search_params, only: ['search']

	def test
		puts params
	end

	def search
		puts 'mabite mabite'
		puts 'mabite mabite'
		puts 'mabite mabite'
		products_search_params = compute_search_filters
		c = products_search_params[:categories].join(',')
		results = ActiveRecord::Base.connection.execute("SELECT product_id FROM categories_products WHERE category_id IN (#{c});")
		products_ids = []
		results.each do |row|
			products_ids << row['product_id']
		end

		redirect_params = {}
		redirect_params[:product_id] = products_ids

		redirect_to controller: 'products', action: 'index_with_filters', params: redirect_params
	end

	def search_params
		params.require(:search).permit(:location, :keyword, categories: [])
	end

	def compute_search_filters
		permited = search_params
		@products_search_params = {}

		if permited[:categories]
			@products_search_params[:categories] = permited[:categories]
		end

		@products_search_params
	end
end