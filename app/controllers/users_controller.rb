class UsersController < ApplicationController
    skip_before_action :authorized, only: [:index, :create]

    def index
        @users = User.all
        byebug
        render json: @users.with_attached_image
    end

    def show
        @current_user = User.find(params[:id])
        @prefs = @current_user.preference
        @users_to_return = []

        @users = User.all.where('age BETWEEN ? AND ?', @prefs.min_age, @prefs.max_age)

        ['male', 'female', 'other', 'non-binary'].each do |gender_type|
            if(gender_type === 'male')
                this_gender = 'men'
            elsif(gender_type === 'female')
                this_gender = 'women'
            else
                this_gender = gender_type
            end
            if @prefs["wants_#{this_gender}"] == true
                @users_to_return.concat(@users.select{|user| user.gender.downcase == gender_type})
            end
        end

        ['dog', 'cat', 'fish', 'reptile', 'bird', 'exotic', 'rodent'].each do |pet_type|
            if(!@prefs["wants_#{pet_type}"])
                @users_to_return.select! do |user| 
                    if !user.pets.any? {|pet| pet.category.downcase === pet_type}
                        user
                    end
                end
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
            user.preference[gender_check] === true
        end

        @current_user_pet_categories = @current_user.pets.map do |pet|
            puts '================================================================================================================'
            pet.category
        end

        @users_to_return.select! do |user| 
            wants = true
            puts user
            puts user.preference
            @current_user_pet_categories.each do |category|
                puts category
                puts user.preference["wants_#{category.downcase}"]
                if !user.preference["wants_#{category.downcase}"]
                    wants = false
                end
            end
            wants
        end


        puts @current_user_pet_categories

        render json: @users_to_return
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
