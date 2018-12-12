require 'geocoder'
class SearchesController < ApplicationController

	before_action :search_params, only: ['search']

	def keyword_filter(keyword)
	end
	
	def location_filter(range)
		max = range.split(',')
		id_inventories = []

		User.all.pluck('id', 'address_id').each do |id, address_id|
			if !address_id.nil?
				d = Address.find(address_id).distance_from(current_user.address.geocode, :km)
				if !d.nil?
					if d >= max[0].to_f && d <= max[1].to_f
						id_inventories << Inventory.where(user_id: id).pluck('id')
					end
				end
			end
		end
		id_inventories.join(', ')
	end

	def categories_filter(categories)
		products_ids = []
		if !categories.nil?
			c = categories.join(',')
			results = ActiveRecord::Base.connection.execute("SELECT DISTINCT product_id FROM categories_products WHERE category_id IN (#{c});")
			
			results.each do |row|
				products_ids << row['product_id'].to_s
			end
		end

		products_ids.join(',')
	end

	def search
		ids = compute_filters
		redirect_params =  { product_id: ids }

		redirect_to controller: 'products', action: 'index_with_filters', params: redirect_params
	end

	def search_params
		params.require(:search).permit(:location, :keyword, categories: [])
	end

	def compute_filters
		permited = search_params
		id_inventories = location_filter(permited[:location])
		products_ids = categories_filter(permited[:categories])

		filter_by_user = "products.inventory_id IN (#{id_inventories})"
		filter_by_categories = "id IN (#{products_ids})"
		global_sql = "SELECT DISTINCT id from products"

		# On test le résultat des filtres pour connaitre la requête SQL à appliquer.
		if !products_ids.empty? && !id_inventories.empty?
			global_sql = "#{global_sql} WHERE #{filter_by_user} AND #{filter_by_categories};"
		elsif products_ids.empty? && !id_inventories.empty?
			global_sql = "#{global_sql} WHERE #{filter_by_user};"
		elsif !products_ids.empty? && id_inventories.empty?
			global_sql = "#{global_sql} WHERE #{filter_by_categories};"
		end

		products = []
		puts global_sql
		ActiveRecord::Base.connection.execute(global_sql).each do |row|
			products_ids << row['id']
		end

		products_ids
	end
end