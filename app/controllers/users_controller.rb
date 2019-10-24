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
        if @prefs.wants_men == true
            @users_to_return.concat(@users.select{|user| user.gender.downcase == 'male'})
        end
        if @prefs.wants_women == true 
            @users_to_return.concat(@users.select{|user| user.gender.downcase == 'female'})
        end
        if @prefs.wants_other == true
            @users_to_return.concat(@users.select{|user| user.gender.downcase == 'other'})
        end
        if @prefs.wants_non_binary == true 
            @users_to_return.concat(@users.select{|user| user.gender.downcase == 'non-binary'})
        end

        if(!@prefs.wants_dog)
            @users_to_return.select! do |user| 
                if !user.pets.any? {|pet| pet.category.downcase === 'dog'}
                    user
                end
            end
        end
        if(!@prefs.wants_cat)
            @users_to_return.select! do |user| 
                if !user.pets.any? {|pet| pet.category.downcase === 'cat'}
                    user
                end
            end
        end
        if(!@prefs.wants_fish)
            @users_to_return.select! do |user| 
                if !user.pets.any? {|pet| pet.category.downcase === 'fish'}
                    user
                end
            end
        end
        if(!@prefs.wants_cat)
            @users_to_return.select! do |user| 
                if !user.pets.any? {|pet| pet.category.downcase === 'reptile'}
                    user
                end
            end
        end
        if(!@prefs.wants_bird)
            @users_to_return.select! do |user| 
                if !user.pets.any? {|pet| pet.category.downcase === 'bird'}
                    user
                end
            end
        end
        if(!@prefs.wants_exotic)
            @users_to_return.select! do |user| 
                if !user.pets.any? {|pet| pet.category.downcase === 'exotic'}
                    user
                end
            end
        end
        if(!@prefs.wants_rodent)
            @users_to_return.select! do |user| 
                if !user.pets.any? {|pet| pet.category.downcase === 'rodent'}
                    user
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

        # @users_to_return.select! do |user|
        #     user[gender_check] === true
        # end



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

    def show
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
