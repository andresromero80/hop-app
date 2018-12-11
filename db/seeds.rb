# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)
require 'faker'


#Create address
3.times do |index|
	address = Address.create!(street_number: "13", street: 'rue des hortensias', city: 'ploufragan', postal_code: '22440', country: "France")
		
end 

# User.create(firstname: "A", lastname: "B", number: "1234567", email: "1@1.com", address_id: 1, password: "123456")

#Create users
3.times do |index|
  user = User.create!(firstname: Faker::Name.first_name, lastname: Faker::Name.last_name, 
  	number: "1234567", email: "#{index+1}@#{index+1}.com", address_id: index+1, password: "123456")
end

#Create inventory
3.times do |index|
  inventory = Inventory.create!(user_id: index+1)
end

#Create products
3.times do |index|
  product = Product.create!(short_desc: Faker::Name.first_name, long_desc: Faker::Name.last_name, 
  	brand: "1234567", available: true, title: Faker::Hipster.word, inventory_id:index + 1)
end
# #Create gossips
# 20.times do |index|
#   gossip = Gossip.create!(title: Faker::Book.title, content: Faker::Movie.quote, date:Faker::Time.forward(23, :morning), user_id: User.first.id + rand(10))
# end

#Create Categories
3.times do |index|
	category = Category.create!(name: Faker::Hipster.word)
end 

# # Association Tags Gossips
# 10.times do |index|
# 	number = 1 + rand(10)
# 		number.times do
# 			Gossip.find(index+1).tags << Tag.find(Tag.first.id + rand(10))
# 		end 
# end 
