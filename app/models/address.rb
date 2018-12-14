class Address < ApplicationRecord
	has_one :user
	geocoded_by :full_address

	# after_validation :geocode

	def full_address
		["#{self.street}", self.city, self.country].compact.join(', ')
	end
	
	def to_string
		self.street + ', ' + self.postal_code + ' ' + self.city + ', ' + self.country
	end
end