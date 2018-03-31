# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)
require 'open-uri'
require 'open_uri_redirections'

10.times do |_n|
  Organizer.create!(name: Faker::SiliconValley.unique.character, description: Faker::Lorem.paragraph(10))
end

80.times do |_n|
  name = Faker::ProgrammingLanguage.name + [' митап', ' конференция'].sample
  # region = Faker::Address.state
  city = Faker::Address.city
  address = Faker::Address.street_address
  date = Faker::Time.between(1.years.ago, Faker::Time.forward(60, :morning))
  description = Faker::Lorem.paragraph(30)
  link = 'https://www.google.com'
  organizer_id = rand(1..Organizer.all.length)
  Event.create!(
    name: name,
    # region: region,
    city: city,
    address: address,
    date: date,
    description: description,
    link: link,
    organizer_id: organizer_id,
    event_image: open('https://picsum.photos/300/300/?random')
  )
end
