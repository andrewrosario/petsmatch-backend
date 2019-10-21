class AuthController < ApplicationController
    skip_before_action :authorized, only: [:create]

    @user = User.find_by(username: params[:username])
    if @user && @user.authenticate(params[:password])
      # encode token comes from ApplicationController
      token = encode_token({ user_id: @user.id })
      render json: { user: @user, jwt: token }, status: :accepted
    else
      render json: { message: 'Invalid username or password' }, status: :unauthorized
    end

    private

    def user_login_params
        params.require(:user).permit(:username, :password)
    end
end