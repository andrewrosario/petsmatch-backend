module Types
  class QueryType < Types::BaseObject
    # Add root-level fields here.
    # They will be entry points for queries on your schema.

    # TODO: remove me
    field :users, [Types::UserType], null: false do
          argument :limit, Integer, default_value: 20, required: false, prepare: ->(limit, ctx) {[limit, 30].min}
    end

    def users(limit:)
      User.all.limit(limit)
    end

    field :pets,
          [Types::PetType],
          null: false,
          description: 'returns all the pets'

    def pets
      Pet.all
    end
  end
end
