class PreferencesController < ApplicationController

    def create
        @preference = Preference.create(preference_params)
        render json: @preference.as_json(include: :user)
    end

    private

    def preference_params
        params.require(:preference).permit(:min_age, :max_age, :pet_type, :wants_men, :wants_women, :wants_other, :wants_non_binary, :user_id)
    end
end
