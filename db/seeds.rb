require 'faker'

Renting.destroy_all
puts "everything destroyed"
Plant.destroy_all
puts "everything destroyed"
User.destroy_all
puts "everything destroyed"


user1 = User.new(
  email: "exemple1@email.com",
  password: "exemple1",
  username: Faker::Internet.unique.username,
  first_name: Faker::Name.first_name,
  last_name: Faker::Name.last_name,
  address: Faker::Address.full_address
  )

user1.photo.attach(
  io: URI.open("https://avatars.githubusercontent.com/u/174240123\?v\=4"),
  filename: "avatar-tim.jpg",
  content_type: 'image/jpg'
)

user1.save

user2 = User.new(
  email: "exemple2@email.com",
  password: "exemple2",
  username: Faker::Internet.unique.username,
  first_name: Faker::Name.first_name,
  last_name: Faker::Name.last_name,
  address: Faker::Address.full_address
  )

user2.photo.attach(
  io: URI.open("https://avatars.githubusercontent.com/u/128395387\?v\=4"),
  filename: "avatar-meryem.jpg",
  content_type: 'image/jpg'
)

user2.save

puts "#{User.count} users created!"

plants_data = [
  {
    name: "Ficus Benjamina",
    category: "Indoor",
    description: "A popular houseplant with elegant drooping branches and glossy leaves.",
    price: 25,
    user_id: user1.id,
    photo1: "https://media.gerbeaud.net/2023/08/640/ficus-benjamina.jpg",
    photo2: "https://cdn.webshopapp.com/shops/30495/files/448468219/ficus-benjamina-danielle-plante-dappartement-pot-2.jpg",
    file_name: "ficus-benjamina"
  },
  {
    name: "Monstera Deliciosa",
    category: "Indoor",
    description: "Known for its large, split leaves, this plant adds a tropical touch to any room.",
    price: 40,
    user_id: user2.id,
    photo1: "https://imgix.be.green/63871aa39676b587083168.jpg\?auto\=compress",
    photo2: "https://cdn.webshopapp.com/shops/30495/files/447582333/monstera-deliciosa-hauteur-70-80cm-plante-gruyere.jpg",
    file_name: "monstera"
  },
  {
    name: "Lavender",
    category: "Outdoor",
    description: "A fragrant herb with calming properties, perfect for gardens and patios.",
    price: 15,
    user_id: user2.id,
    photo1: "https://celebratedherb.com/wp-content/uploads/2024/06/lavender_planter.jpeg",
    photo2: "https://www.datocms-assets.com/33130/1615324347-lavenderpottedherbs.jpg\?h\=500",
    file_name: "lavender"
  }
]

plants_data.each do |plant_data|
  plant = Plant.new
  plant.name = plant_data[:name]
  plant.category = plant_data[:category]
  plant.description = plant_data[:description]
  plant.price = plant_data[:price]
  plant.user_id = plant_data[:user_id]
  plant.photos.attach(
    io: URI.open(plant_data[:photo1]),
    filename: "#{plant_data[:file_name]}.jpg",
    content_type: 'image/jpg'
  )
  plant.photos.attach(
    io: URI.open(plant_data[:photo2]),
    filename: "#{plant_data[:file_name]}2.jpg",
    content_type: 'image/jpg'
  )
  plant.save
end

puts "#{Plant.count} plants created!"

renting1 = Renting.create!(
  start_date: Date.today,
  end_date: Date.today + 7.days,
  status: "Demande acceptée",
  plant_id: Plant.find_by(name: "Ficus Benjamina").id,
  user_id: user2.id
)

renting2 = Renting.create!(
  start_date: Date.today + 1.day,
  end_date: Date.today + 10.days,
  status: "Demande en attente",
  plant_id: Plant.find_by(name: "Monstera Deliciosa").id,
  user_id: user1.id
)
puts "#{Renting.count} rentings created!"
