module Types
  class PetType < Types::BaseObject
    field :name, String, null: false
    field :age, Integer, null: false
    field :category_type, String, null: false

    def category_type
      [object.category, object.pet_type].join(' - ')
    end
  end
end
