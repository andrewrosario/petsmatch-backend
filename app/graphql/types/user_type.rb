module Types
  class UserType < Types::BaseObject
    field :id, ID, null: false
    field :name, String, null: false
    field :age, Integer, null: false
    field :gender, String, null: false
    field :bio, String, null: false
    field :zipcode, Integer, null: false
    field :pets, [Types::PetType], null: false
    field :pet_count, Integer, null: false

    def pet_count
      object.pets.size
    end
  end
end
