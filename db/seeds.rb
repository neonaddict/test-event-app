# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)

Organizer.create!(name:'Sample Organizer', description: Faker::Lorem.sentence(3))

30.times do |n|
    name = Faker::ProgrammingLanguage.name + ' meetup'
    region = Faker::Address.state
    city = Faker::Address.city
    address = Faker::Address.street_address
    description =Faker::Lorem.sentence(3)
    date = Faker::Date.between(10.days.ago, Date.today)
    begin_time = Faker::Time.forward(23, :morning)
    Event.create!(
        name: name,
        region: region,
        city: city,
        address: address,
        description: description,
        date: date,
        organizer_id: 1
    )
end
