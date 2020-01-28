class UsersController < ApplicationController
  skip_before_action :authorized, only: %i[index create]

  def index
    @users = User.all
    render json: @users.with_attached_image
  end

  def show
    @current_user = User.find(params[:id])
    @prefs = @current_user.preference
    @users_to_return = []
    @users = User.all.where('age BETWEEN ? AND ?', @prefs.min_age, @prefs.max_age)



    %w[male female other non-binary].each do |gender_type|
      this_gender = if gender_type == 'male'
                      'men'
                    elsif gender_type == 'female'
                      'women'
                    else
                      gender_type
                    end
      if @prefs["wants_#{this_gender}"] == true
        @users_to_return.concat(@users.select{ |user| user.gender.downcase == gender_type })
      end
    end

    %w[dog cat fish reptile bird exotic rodent].each do |pet_type|
      next if @prefs["wants_#{pet_type}"]

      @users_to_return.select! do |user|
        user unless user.pets.any? { |pet| pet.category.downcase == pet_type }
      end
    end

    case @current_user.gender.downcase
    when 'male'
      gender_check = 'wants_men'
    when 'female'
      gender_check = 'wants_women'
    when 'other'
      gender_check = 'wants_other'
    when 'non-binary'
      gender_check = 'wants_non_binary'
    end

    @users_to_return.select! do |user|
      user.preference[gender_check] == true
    end

    @current_user_pet_categories = @current_user.pets.map(&:category)

    @users_to_return.select! do |user|
      wants = true
      @current_user_pet_categories.each do |category|
        wants = false unless user.preference["wants_#{category.downcase}"]
      end
      wants
    end
    render json: @users_to_return
  end

  def create
    @user = User.create(user_params)
    if @user.valid?
      token = encode_token(user_id: @user.id)
      render json: { user: @user.as_json(include: %i[pets preference]), jwt: token }, status: :created
    else
      render json: { error: 'failed to create user' }, status: :not_acceptable
    end
  end

  def update
    @user = User.find(params[:id])
    @user.update(user_params)
    render json: @user.as_json(include: :pets)
  end

  def profile
    @user = User.find(params[:id])
    render json: @user
  end

  private

  def user_params
    params.permit(:id, :name, :email, :password, :password_confirmation, :age, :gender, :bio, :zipcode, :image)
  end
end
