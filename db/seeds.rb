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
merchant_1 = Merchant.create(name: "Meg's Paper Shop", address: '123 Paper Rd.', city: 'Denver', state: 'CO', zip: 80203)
merchant_2 = Merchant.create(name: "Joe's Tire Shop", address: '123 Tire Rd.', city: 'Salt Lake City', state: 'UT', zip: 80444)
merchant_3 = Merchant.create(name: "Brian's Dog Shop", address: '125 Doggo St.', city: 'Orange County', state: 'CA', zip: 80200)

#paper_shop_items
paper = merchant_1.items.create(name: "Lined Paper", description: "Great for writing on!", price: 20, image: "https://cdn.vertex42.com/WordTemplates/images/printable-lined-paper-wide-ruled.png", inventory: 35)
pencil = merchant_1.items.create(name: "Yellow Pencil", description: "You can write on paper with it!", price: 2, image: "https://images-na.ssl-images-amazon.com/images/I/31BlVr01izL._SX425_.jpg", inventory: 100)
calculator = merchant_1.items.create(name: "Calculator", description: "Makes math easy", price: 100, image: "https://encrypted-tbn0.gstatic.com/images?q=tbn%3AANd9GcSdrF1u_GSYOgpnRJ-2EC87fkfF8sVBC2LZ4A&usqp=CAU", inventory: 9)
paper_weight = merchant_1.items.create(name: "Paper Weight", description: "Hold all your files in place", price: 25, image: "https://encrypted-tbn0.gstatic.com/images?q=tbn%3AANd9GcSdrF1u_GSYOgpnRJ-2EC87fkfF8sVBC2LZ4A&usqp=CAU", inventory: 10)


#tire shop items
tire = merchant_2.items.create(name: "Gatorskins", description: "They'll never pop!", price: 123, image: "https://www.rei.com/media/4e1f5b05-27ef-4267-bb9a-14e35935f218?size=784x588", inventory: 12)
big_tires = merchant_2.items.create(name: "Car Tires", description: "Great tred", price: 250, image: "https://encrypted-tbn0.gstatic.com/images?q=tbn%3AANd9GcSdrF1u_GSYOgpnRJ-2EC87fkfF8sVBC2LZ4A&usqp=CAU", inventory: 8)
off_road_tires = merchant_2.items.create(name: "Off Road Tires", description: "Adventure anywhere!", price: 200, image: "https://encrypted-tbn0.gstatic.com/images?q=tbn%3AANd9GcSdrF1u_GSYOgpnRJ-2EC87fkfF8sVBC2LZ4A&usqp=CAU", inventory: 16)

#dog_shop items
pull_toy = merchant_3.items.create(name: "Pull Toy", description: "Great pull toy!", price: 10, image: "http://lovencaretoys.com/image/cache/dog/tug-toy-dog-pull-9010_2-800x800.jpg", inventory: 32)
dog_bone = merchant_3.items.create(name: "Dog Bone", description: "They'll love it!", price: 21, image: "https://img.chewy.com/is/image/catalog/54226_MAIN._AC_SL1500_V1534449573_.jpg", inventory: 21)
stuffed_animal = merchant_3.items.create(name: "Stuffed Animal", description: "Your dogs favorite cuddle buddy", image: "https://encrypted-tbn0.gstatic.com/images?q=tbn%3AANd9GcSdrF1u_GSYOgpnRJ-2EC87fkfF8sVBC2LZ4A&usqp=CAU", price: 15, inventory: 15)
leash = merchant_3.items.create(name: "Leash", description: "Keep your dog close by", price: 15, image: "https://encrypted-tbn0.gstatic.com/images?q=tbn%3AANd9GcSdrF1u_GSYOgpnRJ-2EC87fkfF8sVBC2LZ4A&usqp=CAU", inventory: 5)
