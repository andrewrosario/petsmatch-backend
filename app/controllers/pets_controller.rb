class PetsController < ApplicationController

    def index
        @pets = Pet.all 
        render json: @pets.as_json(include: :user)
    end

    def create
        @pet = Pet.create(pet_params)
        render json: @pet.as_json(include: :user)
    end

    def show
        @pet = Pet.find(params[:id])
        render json: @pet.as_json(include: :user)
    end

    private

    def pet_params
        params.require(:pet).permit(:name, :age, :species, :breed, :category, :user_id)
    end
end
