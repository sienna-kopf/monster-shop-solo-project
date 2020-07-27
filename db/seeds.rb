# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)

Merchant.destroy_all
Item.destroy_all

#merchants
merchant1 = Merchant.create(name: "Meg's Bike Shop", address: '123 Bike Rd.', city: 'Denver', state: 'CO', zip: 80203)
merchant2 = Merchant.create(name: "Meg's Tire Shop", address: '123 Tire Rd.', city: 'Denver', state: 'CO', zip: 80403)
merchant3 = Merchant.create(name: "Meg's Tire Shop", address: '123 Tire Rd.', city: 'Denver', state: 'CO', zip: 80403)
merchant4 = Merchant.create(name: "Meg's Tire Shop", address: '123 Tire Rd.', city: 'Denver', state: 'CO', zip: 80403)
merchant5 = Merchant.create(name: "Meg's Bike Shop", address: '123 Bike Rd.', city: 'Denver', state: 'CO', zip: 80203)
merchant6 = Merchant.create(name: "Brian's Dog Shop", address: '125 Doggo St.', city: 'Denver', state: 'CO', zip: 80210)

#bike_shop items
tire = merchant5.items.create(name: "Gatorskins", description: "They'll never pop!", price: 123, image: "https://www.rei.com/media/4e1f5b05-27ef-4267-bb9a-14e35935f218?size=784x588", inventory: 12)

#dog_shop items
pull_toy = merchant6.items.create(name: "Pull Toy", description: "Great pull toy!", price: 10, image: "http://lovencaretoys.com/image/cache/dog/tug-toy-dog-pull-9010_2-800x800.jpg", inventory: 32)
dog_bone = merchant6.items.create(name: "Dog Bone", description: "They'll love it!", price: 21, image: "https://img.chewy.com/is/image/catalog/54226_MAIN._AC_SL1500_V1534449573_.jpg", inventory: 21)


big_tires = merchant2.items.create(name: "Gatorskins", description: "They'll never pop!", price: 100, image: "https://www.rei.com/media/4e1f5b05-27ef-4267-bb9a-14e35935f218?size=784x588", inventory: 12)

paper = merchant1.items.create(name: "Lined Paper", description: "Great for writing on!", price: 20, image: "https://cdn.vertex42.com/WordTemplates/images/printable-lined-paper-wide-ruled.png", inventory: 35)
pencil = merchant1.items.create(name: "Yellow Pencil", description: "You can write on paper with it!", price: 2, image: "https://images-na.ssl-images-amazon.com/images/I/31BlVr01izL._SX425_.jpg", inventory: 100)

toy_plane = merchant3.items.create(name: "Yellow Pencil", description: "You can write on paper with it!", price: 8, image: "https://images-na.ssl-images-amazon.com/images/I/31BlVr01izL._SX425_.jpg", inventory: 90)
orange = merchant3.items.create(name: "Yellow Pencil", description: "You can write on paper with it!", price: 4, image: "https://images-na.ssl-images-amazon.com/images/I/31BlVr01izL._SX425_.jpg", inventory: 55)

stuffed_animal = merchant4.items.create(name: "Yellow Pencil", description: "You can write on paper with it!", price: 6, image: "https://images-na.ssl-images-amazon.com/images/I/31BlVr01izL._SX425_.jpg", inventory: 15)
maple_syrup = merchant4.items.create(name: "Yellow Pencil", description: "You can write on paper with it!", price: 89, image: "https://images-na.ssl-images-amazon.com/images/I/31BlVr01izL._SX425_.jpg", inventory: 5)
