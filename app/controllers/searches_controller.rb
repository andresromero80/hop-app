require 'geocoder'
class SearchesController < ApplicationController

	before_action :search_params, only: ['search']

	def keyword_filter(keyword)
	end
	
	def location_filter(range)
		result = nil
		id_inventories = []
		if !current_user.address.nil?
			current_user_address = current_user.address
			@addresses = Address.all.where.not(latitude: nil)
			if !@addresses.nil?
				@addresses.each do |a|
					begin
						diff = a.distance_from(current_user_address.geocode, :km)
						if !diff.nil?
							if diff >= range.to_f
								user_id = User.where(address_id: a.id)
								id_inventories << Inventory.where(user_id: user_id).pluck('id')
							end
						end
					rescue StandardError => e
						puts e.message
					end
				end
			end
		end
		
		if !id_inventories.empty?
			result = id_inventories.join(', ')
		end

		return result
	end

	def categories_filter(categories)
		result = nil

		if !categories.nil?
			products_ids = []
			c = categories.join(',')
			results = ActiveRecord::Base.connection.execute("SELECT DISTINCT product_id FROM categories_products WHERE category_id IN (#{c});")
			
			results.each do |row|
				products_ids << row['product_id'].to_s
			end

			result = products_ids.join(',')
		end

		return result
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

		if permited[:categories].class == "Array"
			if !permited[:categories].empty?
				products_ids = categories_filter(permited[:categories])
				filter_by_categories = "id IN (#{products_ids})"
			end
		end

		if permited[:location] != "" && permited[:location] != nil
			id_inventories = location_filter(permited[:location])
			filter_by_user = "products.inventory_id IN (#{id_inventories})"
		end

		global_sql = "SELECT DISTINCT id from products"
		# On test le résultat des filtres pour connaitre la requête SQL à appliquer.
		if products_ids && id_inventories
			if !products_ids.nil? && !id_inventories.nil?
				global_sql = "#{global_sql} WHERE #{filter_by_user} AND #{filter_by_categories};"
			end
		elsif !products_ids && id_inventories
			if !id_inventories.nil?
				global_sql = "#{global_sql} WHERE #{filter_by_user};"
			end
		elsif products_ids && !id_inventories
			if !products_ids.nil?
				global_sql = "#{global_sql} WHERE #{filter_by_categories};"
			end
		else
			global_sql += ";"
		end

		chaine = ''
		ActiveRecord::Base.connection.execute(global_sql).each do |row|
			if chaine.length == 0
				chaine += row['id'].to_s
			else
				chaine += ',' + row['id'].to_s
			end
		end
		chaine
	end
end