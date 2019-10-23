class UsersController < ApplicationController
    skip_before_action :authorized, only: [:index, :create]

    def index
        @users = User.all 
        render json: @users.with_attached_image
    end

    def create
        @user = User.create(user_params)
        if @user.valid?
            token = encode_token({ user_id: @user.id })
            render json: { user: @user.as_json(include: [:pets, :preference]), jwt: token }, status: :created
          else
            render json: { error: 'failed to create user' }, status: :not_acceptable
          end
    end
    
    def user_params
        params.require(:user).permit(:name, :email, :password, :password_confirmation, :age, :gender, :bio, :zipcode, :image)
    end

    def profile
        @user = User.find(params[:id])
        render json: @user
    end
end
