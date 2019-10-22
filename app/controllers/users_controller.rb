class UsersController < ApplicationController
    skip_before_action :authorized, only: [:index, :create]

    def index
        @users = User.all 
        render json: @users.with_attached_image
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

    def profile
        @user = User.find(params[:id])
        url = url_for(@user.image)
        render json: @user.as_json(include: [{image: {include: :blob}}, {pets: {include: {image: {include: :blob}}}}])
    end
end
