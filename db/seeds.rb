# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)
require 'faker'



# # #Create address
# 3.times do |index|
# 	address = Address.create!(street_number: "123", street: Faker::StarWars.planet, city: Faker::StarWars.planet, postal_code: Faker::Address.building_number, country: "France")

# User.create(firstname: "A", lastname: "B", number: "1234567", email: "1@1.com", address_id: 1, password: "123456")


# #Create products
# 3.times do |index|
#   product = Product.create!(short_desc: Faker::Name.first_name, long_desc: Faker::Name.last_name, 
#   	brand: "1234567", available: true, title: Faker::Hipster.word, inventory_id:index + 1)
# end


#Create Categories
# 3.times do |index|
	category = Category.create!(name: "Spectacle")
	category = Category.create!(name: "Cinéma")
	category = Category.create!(name: "Travaux d'entretien")
	category = Category.create!(name: "réparations d'objets")
