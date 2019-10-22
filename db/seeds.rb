# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)
require 'faker'

100.times do |i|
    this_user = User.create(
        name: Faker::Name.name,
        age: rand(18...99),
        gender: Faker::Gender.type,
        bio: Faker::GreekPhilosophers.quote,
        email: Faker::Internet.unique.email,
        password: 'password',
        password_confirmation: 'password',
        zipcode: 78701
    )
    this_user.image.attach(io: File.open(File.join(File.dirname(__FILE__), 'user.png')), filename: 'user.png')
    rand(1...3).times do |j|
        this_pet = Pet.create(
            user_id: i + 1,
            name: Faker::Creature::Dog.name,
            age: rand(1...20),
            pet_type: Faker::Creature::Dog.breed,
            category: ['Cat', 'Dog', 'Fish', 'Bird', 'Reptile', 'Exotic'].sample
        )
        this_pet.image.attach(io: File.open(File.join(File.dirname(__FILE__), 'Random-25-512.png')), filename: 'Random-25-512.png')
    end
end


