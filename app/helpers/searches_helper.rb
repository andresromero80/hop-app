module SearchesHelper
	attr_accessor :request_params

	def search_params
		@request_params.require(:search).permit(:location, :keyword, categories: [])
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