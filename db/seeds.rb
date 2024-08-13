require 'faker'

Plant.destroy_all
puts "everything destroyed"
User.destroy_all
puts "everything destroyed"
Renting.destroy_all
puts "everything destroyed"


user1 = User.create!(
  email: "exemple1@email.com",
  password: "exemple1",
  username: Faker::Internet.unique.username,
  first_name: Faker::Name.first_name,
  last_name: Faker::Name.last_name,
  address: Faker::Address.full_address
  )

user2 = User.create!(
  email: "exemple2@email.com",
  password: "exemple2",
  username: Faker::Internet.unique.username,
  first_name: Faker::Name.first_name,
  last_name: Faker::Name.last_name,
  address: Faker::Address.full_address
  )

puts "#{User.count} users created!"

plants_data = [
  {
    name: "Ficus Benjamina",
    category: "Indoor",
    description: "A popular houseplant with elegant drooping branches and glossy leaves.",
    price: 25,
    user_id: user1.id
  },
  {
    name: "Monstera Deliciosa",
    category: "Indoor",
    description: "Known for its large, split leaves, this plant adds a tropical touch to any room.",
    price: 40,
    user_id: user2.id
  },
  {
    name: "Lavender",
    category: "Outdoor",
    description: "A fragrant herb with calming properties, perfect for gardens and patios.",
    price: 15,
    user_id: user2.id
  }
]


plants_data.each do |plant_data|
  plant = Plant.new
  plant.name = plant_data[:name]
  plant.category = plant_data[:category]
  plant.description = plant_data[:description]
  plant.price = plant_data[:price]
  plant.user_id = plant_data[:user_id]
  plant.save
end
puts "#{Plant.count} plants created!"

renting1 = Renting.create!(
  start_date: Date.today,
  end_date: Date.today + 7.days,
  status: "disponible",
  plant_id: Plant.find_by(name: "Ficus Benjamina").id,
  user_id: user2.id
)

renting2 = Renting.create!(
  start_date: Date.today + 1.day,
  end_date: Date.today + 10.days,
  status: "non disponible",
  plant_id: Plant.find_by(name: "Monstera Deliciosa").id,
  user_id: user1.id
)
puts "#{Renting.count} rentings created!"
