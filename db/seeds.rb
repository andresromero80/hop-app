# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)
require 'faker'

require 'mime-types'
# require 'filemagic'


# #Create address
10.times do |index|
	address = Address.create!(street: Faker::StarWars.planet, city: Faker::StarWars.planet, postal_code: Faker::Address.building_number, country: "France")
end 

# # User.create(firstname: "A", lastname: "B", number: "1234567", email: "1@1.com", address_id: 1, password: "123456")

# #Create users
10.times do |index|
  user = User.create!(firstname: Faker::Name.first_name, lastname: Faker::Name.last_name, 
  	number: "1234567", email: "#{index+1}@#{index+1}.com", address_id: index+1, password: "123456")
end

# #Create inventory
10.times do |index|
  inventory = Inventory.create!(user_id: index+1)
end

brands = ["YAMAHA", "MARSHALL", "NAKAMURA", "GREENCUT", "SENNHEISER", "PIREX", "TEFAL", "Moulinex", "Au Petit Fromton"]
(brands.size - 1).times do |index|
  Brand.create(name: brands[index])
end
#Create products

#Create Categories
# 3.times do |index|
  category = Category.create!(name: "Spectacle")
  category = Category.create!(name: "Cinéma")
  category = Category.create!(name: "Travaux d'entretien")
  category = Category.create!(name: "réparations d'objets")
# end
# 9 produits

  index = 0
  product = Product.create(short_desc: "Guitare sympa en bonne qualité", long_desc: "Guitare sympa en bonne qualité",
    	brand_id: rand(1...(brands.size)), available: true, title: "YAMAHA ETUDE C40 A 4/4",
      inventory_id: index + 1)

  img = open("https://www.woodbrass.com/images/woodbrass/MMA+MG15GFX.JPG")
  content_type = img.content_type.split('/')[1]

  product = Product.last
  name = product.title.gsub(' ', "").gsub("/", "")
  product.uploads.attach(io: img  , filename: "#{name}.#{content_type}")
  product.categories << Category.find(4)

  index = 1

  Product.create!(short_desc: "Superbe ampli MARSHALL presque neuf", long_desc: "MARSHALL MG15GFX - FINITION OR",
    brand_id: rand(0...brands.size), available: true, title: "MARSHALL MG15GFX - FINITION OR",
    inventory_id: index + 1)

    
  img = open("https://www.woodbrass.com/images/woodbrass/MMA+MG15GFX.JPG")
  content_type = img.content_type.split('/')[2]

  product = Product.last
  name = product.title.gsub(' ', "").gsub("/", "")
  product.uploads.attach(io: img  , filename: "#{name}.#{content_type}")
  product.categories << Category.find(4)

  index = 2

  Product.create!(short_desc: "VTC nikel pour se ballader en ville !", long_desc: "Vélo de ville CITY 50 NOIR NAKAMURA",
    	brand_id: rand(0...brands.size), available: true, title: "Vélo de ville CITY 50 NOIR NAKAMURA",
       inventory_id: index + 1)


  img = open("https://media.intersport.fr/is/image/intersportfr/5007088AKU_Q1?$produit_l$&$product_grey$")
  content_type = img.content_type.split('/')[1]

  product = Product.last
  name = product.title.gsub(' ', "").gsub("/", "")
  product.uploads.attach(io: img  , filename: "#{name}.#{content_type}")
  product.categories << Category.find(1)
  
  index = 3

  Product.create!(short_desc: "VTC nikel pour se ballader en ville !", long_desc: "26cc lame de 60cm poignee pivotante -GREENCUT",
    	brand_id: rand(0...brands.size), available: true, title: "Taille-haie a moteur essence ",
       inventory_id: index + 1)


  img = open("https://cdn.manomano.fr/taille-haie-a-moteur-essence-26cc-lame-de-60cm-poignee-pivotante-greencut-P-5299196-9745082_1.jpg")
  content_type = img.content_type.split('/')[1]

  product = Product.last
  name = product.title.gsub(' ', "").gsub("/", "")
  product.uploads.attach(io: img  , filename: "#{name}.#{content_type}")
  product.categories << Category.find(1)

  index = 4

  Product.create!(short_desc: "Tondeuse thermique autotractee", long_desc: "Tondeuse thermique autotractee 165cc largeur 48cm 4-en-1 -GREENCUT",
    	brand_id: rand(0...brands.size), available: true, title: "Tondeuse thermique autotractee",
       inventory_id: index + 1)

  img = open("https://cdn.manomano.fr/tondeuse-thermique-autotractee-165cc-largeur-48cm-4-en-1-greencut-P-1045889-2746593_1.jpg")
  content_type = img.content_type.split('/')[1]

  product = Product.last
  name = product.title.gsub(' ', "").gsub("/", "")
  product.uploads.attach(io: img  , filename: "#{name}.#{content_type}")
  product.categories << Category.find(1)

  index = 5

  Product.create!(short_desc: "Micro bonne qualité", long_desc: "Micro SENNHEISER XS1. Très bonne qualité",
    	brand_id: rand(0...brands.size), available: true, title: "Micro SENNHEISER XS1",
       inventory_id: index + 1)

  img = open("https://www.woodbrass.com/images/woodbrass/SENNHEISER+XS1.JPG")
  content_type = img.content_type.split('/')[1]

  product = Product.last
  name = product.title.gsub(' ', "").gsub("/", "")
  product.uploads.attach(io: img  , filename: "#{name}.#{content_type}")
  product.categories << Category.find(1)

  index = 6

  Product.create!(short_desc: "Thermos Acier", long_desc: "Thermos Acier Inoxydable Double Paroi Flasque 0.47L",
    	brand_id: rand(0...brands.size), available: true, title: "Thermos Acier",
       inventory_id: index + 1)


  img = open("https://images-na.ssl-images-amazon.com/images/I/81E-F2ljyXL._SL1500_.jpg")
  content_type = img.content_type.split('/')[1]

  product = Product.last
  name = product.title.gsub(' ', "").gsub("/", "")
  product.uploads.attach(io: img  , filename: "#{name}.#{content_type}")
  product.categories << Category.find(1)

  index = 7

  Product.create!(short_desc: "Appareil à raclette Moulinex", long_desc: "Appareil à raclette Moulinex RE160811 Accessimo 850 W Noir et Rouge",
    	brand_id: rand(0...brands.size), available: true, title: "Appareil à raclette",
       inventory_id: index + 1)


  img = open("https://static.fnac-static.com/multimedia/Images/FR/MDM/60/94/4e/5149792/1540-1/tsp20180719181118/Appareil-a-raclette-Moulinex-RE160811-Acceimo-850-W-Noir-et-Rouge.jpg")
  content_type = img.content_type.split('/')[1]

  product = Product.last
  name = product.title.gsub(' ', "").gsub("/", "")
  product.uploads.attach(io: img  , filename: "#{name}.#{content_type}")
  product.categories << Category.find(2)

  index = 8

  Product.create!(short_desc: "Râpe électrique rechargeable", long_desc: "Râpe électrique rechargeable",
    	brand_id: rand(0...brands.size), available: true, title: "Râpe électrique rechargeable",
       inventory_id: index + 1)


  img = open("https://cdn.manomano.fr/rape-electrique-rechargeable-P-4461226-8860993_1.jpg")
  content_type = img.content_type.split('/')[1]

  product = Product.last
  name = product.title.gsub(' ', "").gsub("/", "")
  product.uploads.attach(io: img  , filename: "#{name}.#{content_type}")
  product.categories << Category.find(3)