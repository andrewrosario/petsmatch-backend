class UsersController < ApplicationController
    def index
        @users = User.all 
        render json: @users.as_json(include: :pets)
    end
end
