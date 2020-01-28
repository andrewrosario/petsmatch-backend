class PetsController < ApplicationController

  def index
    @pets = Pet.all
    render json: @pets.as_json(include: :user)
  end

  def create
    @pet = Pet.create(pet_params)
    render json: @pet.as_json(include: { user: { include: :preference } })
  end

  def show
    @pet = Pet.find(params[:id])
    render json: @pet
  end

  private

  def pet_params
    params.permit(:name, :age, :category, :pet_type, :user_id, :image)
  end
end


