# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)
require 'faker'
require 'open-uri'

def image_fetcher(num, gender)
    # open(Faker::Avatar.image)
    # rescue
    puts gender
    open("https://randomuser.me/portraits/#{gender}/#{num}.jpg")
end

def pet_image_fetches
    open('http://placegoat.com/200')
end

200.times do |i|
    gender = ['male', 'male', 'male', 'female', 'female', 'female', 'non-binary', 'other'].sample
    this_user = User.create(
        name: Faker::Name.name,
        age: rand(18...50),
        gender: gender,
        bio: Faker::GreekPhilosophers.quote,
        email: Faker::Internet.unique.email,
        password: 'password',
        password_confirmation: 'password',
        zipcode: 78701
    )
    number = rand(1..99)
    if(gender === 'male' || gender === 'female')
        this_user.image.attach({
            io: image_fetcher(number, gender),
            filename: "#{number}.jpg"
        })
    else 
        this_user.image.attach({
            io: image_fetcher(number, 'female'),
            filename: "#{number}.jpg"
        })
    end
    # this_user.image.attach(io: File.open(File.join(File.dirname(__FILE__), 'user.png')), filename: 'user.png')
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
        # this_pet.image.attach(io: File.open(File.join(File.dirname(__FILE__), 'Random-25-512.png')), filename: 'Random-25-512.png')

    end
    age = rand(18..40)
    this_preference = Preference.create(
        user_id: this_user.id,
        min_age: age,
        max_age: age + rand(5..15),
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
    puts this_preference.id
end


