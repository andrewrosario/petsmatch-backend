class UsersController < ApplicationController
    before_action :authenticate_user, except: [:index]

    def index
        @users = User.all 
        render json: @users
    end

    def user_params
        params.require(:user).permit(:name, :username, :password, :password_confirmation, :age, :gender, :bio, :zipcode)
    end
end
