require 'faker'
require "open-uri"
require "nokogiri"

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
  address: "24 rue louis blanc, 75010 paris"
  )

user1.photo.attach(
  io: URI.open("https://avatars.githubusercontent.com/u/174240123\?v\=4"),
  filename: "avatar-tim.jpg",
  content_type: 'image/jpg'
)

sleep(4)

user1.save

user2 = User.new(
  email: "exemple2@email.com",
  password: "exemple2",
  username: Faker::Internet.unique.username,
  first_name: Faker::Name.first_name,
  last_name: Faker::Name.last_name,
  address: "16 villa gaudelet 75011 paris"
  )

user2.photo.attach(
  io: URI.open("https://avatars.githubusercontent.com/u/128395387\?v\=4"),
  filename: "avatar-meryem.jpg",
  content_type: 'image/jpg'
)

sleep(4)

user2.save

puts "#{User.count} users created!"

url = "https://plnts.com/fr/shop/all-plnts/size:l,m,xl,xxl?sort=price-desc"
html_file = URI.open(url).read
html_doc = Nokogiri::HTML.parse(html_file)

plants = html_doc.search("span.m-0.truncate.font-sans.text-sm.font-bold.leading-tight.\\33xl\\:text-base").map do |element|
  plant = Plant.new
  plant.name = element.text
  plant
end

plants.each_index do |index|
  plants[index].price = html_doc.search("span.flex.flex-row.items-center.gap-2.mt-1.text-sm.leading-tight.\\33xl\\:text-base > span")[index]
                                .text.delete("€").to_f
end

details_urls = html_doc.search(".group.relative.flex.flex-col.justify-start").map do |element|
  "https://plnts.com#{element.attribute('href').value}"
end

plants.each_index do |index|
  details_html_file = URI.open(details_urls[index]).read
  details_html_doc = Nokogiri::HTML.parse(details_html_file)
  if details_html_doc.search("p > span").blank?
    plants[index].description = details_html_doc.search("p").first.text
  else
    plants[index].description = details_html_doc.search("p > span").text
  end
end

categories = ["Purificateur", "Déhumidificateur", "Humidificateur", "Remonte l'humeur"]

plants.each do |plant|
  plant.category = categories.sample
  plant.user_id = User.all.sample.id
end

plants.each_index do |index|
  details_html_file = URI.open(details_urls[index]).read
  details_html_doc = Nokogiri::HTML.parse(details_html_file)
  photo_file_name = plants[index].name.delete(" ")
  photo1_url = details_html_doc.search("div.overflow-hidden.absolute.inset-0 img").first.attribute('src').value
  plants[index].photos.attach(
    io: URI.open("https://plnts.com#{photo1_url}"),
    filename: "#{photo_file_name}.jpg",
    content_type: 'image/jpg'
  )
  photo2_url = details_html_doc.search("div.overflow-hidden.absolute.inset-0 img").last.attribute('src').value
  plants[index].photos.attach(
    io: URI.open("https://plnts.com#{photo2_url}"),
    filename: "#{photo_file_name}2.jpg",
    content_type: 'image/jpg'
  )
end

plants.each(&:save!)

puts "#{Plant.count} plants created!"

renting1 = Renting.create!(
  start_date: Date.today,
  end_date: Date.today + 7.days,
  status: "Demande acceptée",
  plant_id: Plant.where.not(user_id: user2.id).sample.id,
  user_id: user2.id
)

renting2 = Renting.create!(
  start_date: Date.today + 1.day,
  end_date: Date.today + 10.days,
  status: "Demande en attente",
  plant_id: Plant.where.not(user_id: user1.id).sample.id,
  user_id: user1.id
)
puts "#{Renting.count} rentings created!"
