# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: "Star Wars" }, { name: "Lord of the Rings" }])
#   Character.create(name: "Luke", movie: movies.first)

# Création d'utilisateurs
10.times do
  User.create(
    first_name: [Faker::Name.first_name, Faker::Name.unique.first_name, Faker::Games::Pokemon.name].sample,
    last_name: [Faker::Name.last_name, Faker::Games::WarhammerFantasy.hero].sample,
    description: Faker::Lorem.paragraph(sentence_count: 2),
    email: Faker::Internet.email(domain: 'yopmail.com'),
    password: "123456"
  )
end

# Création d'évènements
200.times do
  Event.create(
    start_date: Faker::Time.between(from: DateTime.now, to: DateTime.now + 365),
    duration: rand(20..400) * 5,
    title: Faker::Lorem.sentence,
    description: Faker::Lorem.paragraph(sentence_count: 2),
    price: rand(5..1000),
    location: Faker::Address.full_address,
    admin_id: User.pluck(:id).sample
  )
end
