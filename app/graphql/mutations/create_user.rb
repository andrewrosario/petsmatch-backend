module Mutations
  class CreateUser < GraphQL::Schema::Mutation

    type Types::UserType

    # TODO: define arguments
    class Input < GraphQL::Schema::InputObject
      argument :name, String, required: true
      argument :age, Integer, required: true
      argument :gender, String, required: true
      argument :bio, String, required: true
      argument :zipcode, Integer, required: false
    end

    # TODO: define resolve method

    def resolve(input:)
      @user = User.create(name: input[:name],
                      age: input[:age],
                      gender: input[:gender],
                      bio: input[:bio],
                      zipcode: input[:zipcode]
                      )
    end
  end
end
