class UsersController < ApplicationController

    def index
        @users = User.all 
        render json: @users.as_json(include: :pets)
    end

    def profile
        @user = current_user
        render json: @user.as_json(include: :pets)
    end

    def user_params
        params.require(:user).permit(:name, :email, :password, :password_confirmation, :age, :gender, :bio, :zipcode)
    end
end
