class PlantsController < ApplicationController
  def index
    @plants = Plant.all
  end

  def show
    @plant = Plant.find(params[:id])
    @renting = Renting.new
  end

  def new
    @plant = Plant.new
  end

  def create
    @plant = Plant.new(plants_params)
    @plant.save
  end

  def edit
  end

  def update
  end

  def destroy
  end

  private

  def plants_params
    params.require(:plant).permit(:name, :category, :description, :price)
  end
end
