# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)


require 'faker'

10.times do
  user=User.new(
    name: Faker::Internet.user_name,
    email: Faker::Internet.email,
    password: "123456"
  )
  user.save!
  user.posts.create(name: Faker::JapaneseMedia::DragonBall.character, description: Faker::Lorem.paragraph_by_chars(number: 256, supplemental: false))
end