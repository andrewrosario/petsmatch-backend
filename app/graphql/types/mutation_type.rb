module Types
  class MutationType < Types::BaseObject
    field :create_user, mutation: Mutations::CreateUser do
      argument :input, Mutations::CreateUser::Input, required: true
    end
  end
end
