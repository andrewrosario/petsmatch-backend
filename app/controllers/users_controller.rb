class UsersController < ApplicationController
    skip_before_action :authorized, only: [:index, :create]

    def index
        @users = User.all 
        render json: @users.as_json(include: :pets)
    end

    def create
        @user = User.create(user_params)
        if @user.valid?
            render json: @user.as_json(include: :pets), status: :created
          else
            render json: { error: 'failed to create user' }, status: :not_acceptable
          end
    end

    def profile
        @user = current_user
        render json: @user.as_json(include: :pets), status: :accepted
    end

    def user_params
        params.require(:user).permit(:name, :email, :password, :password_confirmation, :age, :gender, :bio, :zipcode)
    end
end
