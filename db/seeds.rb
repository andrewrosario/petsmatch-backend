# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)
require 'faker'
require 'open-uri'

def image_fetcher
    open(Faker::Avatar.image)
    rescue
    open("https://robohash.org/sitsequiquia.png?size=300x300&set=set1")
end

def pet_image_fetches
    open('http://placegoat.com/200')
end

100.times do |i|
    this_user = User.create(
        name: Faker::Name.name,
        age: rand(18...99),
        gender: ['male', 'male', 'male', 'female', 'female', 'female', 'non-binary', 'other'].sample,
        bio: Faker::GreekPhilosophers.quote,
        email: Faker::Internet.unique.email,
        password: 'password',
        password_confirmation: 'password',
        zipcode: 78701
    )
    this_user.image.attach({
        io: image_fetcher,
        filename: "#{i}_faker_image.jpg"
     })
    rand(1...3).times do |j|
        this_pet = Pet.create(
            user_id: i + 1,
            name: Faker::Creature::Dog.name,
            age: rand(1...20),
            pet_type: Faker::Creature::Dog.breed,
            category: ['Cat', 'Dog', 'Fish', 'Bird', 'Reptile', 'Exotic'].sample
        )
        this_pet.image.attach({
            io: pet_image_fetches,
            filename: "#{i}_faker_image.jpg"
         })
    end
    this_preference = Preference.create(
        user_id: i + 1,
        min_age: [18..40].sample,
        max_age: [40..99].sample,
        wants_men: [true, false].sample,
        wants_women:[true, false].sample,
        wants_other:[true, false].sample,
        wants_non_binary:[true, false].sample,
        wants_dog:[true, false].sample,
        wants_cat:[true, false].sample,
        wants_fish:[true, false].sample,
        wants_reptile:[true, false].sample,
        wants_bird:[true, false].sample,
        wants_exotic:[true, false].sample,
        wants_rodent:[true, false].sample,
    )
end


