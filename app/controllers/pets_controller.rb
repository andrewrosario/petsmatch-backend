class PetsController < ApplicationController

    def show
        @pet = Pet.find(params[:id])
        render json: @pet
    end
end
