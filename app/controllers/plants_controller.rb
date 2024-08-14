class PlantsController < ApplicationController
  def index
    @plants = Plant.all
  end

  def show
    @plant = Plant.find(params[:id])
    @renting = Renting.new
    @user = current_user
    @plant_user = @plant.user
  end

  def new
    @plant = Plant.new
  end

  def create
    @plant = Plant.new(plants_params)
    if @plant.save
      redirect_to @plant, notice: "plant was successfully created."
    else
      render :new, status: :unprocessable_entity
    end
  end

  def edit
    @plant = Plant.find(params[:id])
  end

  def update
    @plant.update(plants_params)
  end
  def destroy
  end

  private

  def plants_params
    params.require(:plant).permit(:name, :category, :description, :price, photos: [])
  end
end
