class PreferencesController < ApplicationController

    def create
        @preference = Preference.create(preference_params)
    end

    private

    # def preference_params
    #     params.require(:preference).permit
    # end
end
