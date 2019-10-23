class PreferencesController < ApplicationController
    skip_before_action :authorized, only: [:create]

    def create
        @preference = Preference.create(user_id: params[:user_id])
        render json: @preference.as_json(include: :user)
    end

    def update
        @preference = Preference.find_by(user_id: params[:preference][:user_id])
        @preference.update(preference_params)
        render json: @preference.as_json(include: :user)
    end

    private

    def preference_params
        params.require(:preference).permit(:min_age, :max_age, :pet_type, :wants_men, :wants_women, :wants_other, :wants_non_binary, :wants_dog, :wants_cat, :wants_fish, :wants_reptile, :wants_bird, :wants_exotic, :wants_rodent, :user_id)
    end
end
