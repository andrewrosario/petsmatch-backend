class UsersController < ApplicationController
    def index
        @users = User.all 
        render json: @users.as_json(include: :pets)
    end

    def user_params
        params.require(:user).permit(:name, :username, :password, :password_confirmation, :age, :gender, :bio, :zipcode)
      end
end
