# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)
require 'faker'
require 'open-uri'
require 'rest-client'
require 'json'

def image_fetcher(num, gender)
    puts gender
    open("https://randomuser.me/portraits/#{gender}/#{num}.jpg")
end

def pet_image_fetches(category)
    response = RestClient::Request.execute(
        method: :get,
        url: "https://pixabay.com/api/?key=14031171-f6e96ca716af92cd22ce48f78&q=#{category}+pet&image_type=photo"
        )
        data = JSON[response.body]
        number = rand(1..10)
        puts data['hits'][number]['largeImageURL']
    open(data['hits'][number]['largeImageURL'])
end

300.times do |i|
    gender = ['male', 'male', 'male', 'female', 'female', 'female', 'non-binary', 'other'].sample
    this_user = User.create(
        name: Faker::Name.name,
        age: rand(18...50),
        gender: gender,
        bio: Faker::GreekPhilosophers.quote,
        email: Faker::Internet.unique.email,
        #password: 'password',
        #password_confirmation: 'password',
        zipcode: 78701
    )
    number = rand(1..99)
    if gender === 'male'
        this_user.image.attach({
            io: image_fetcher(number, 'men'),
            filename: "#{number}.jpg"
        })
    elsif gender === 'female'
        this_user.image.attach({
            io: image_fetcher(number, 'women'),
            filename: "#{number}.jpg"
        })
    else
        this_user.image.attach({
            io: image_fetcher(number, 'women'),
            filename: "#{number}.jpg"
        })
    end
    rand(1...3).times do |j|
        category = ['Cat', 'Dog', 'Fish', 'Bird', 'Reptile', 'Exotic'].sample
        this_pet = Pet.create(
            user_id: i + 1,
            name: Faker::Creature::Dog.name,
            age: rand(1...20),
            pet_type: Faker::Creature::Dog.breed,
            category: category
        )

        this_pet.image.attach({
            io: pet_image_fetches(category),
            filename: "#{i}_faker_image.jpg"
         })

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
