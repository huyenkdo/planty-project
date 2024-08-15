class PlantsController < ApplicationController
  def index
    @plants = Plant.all
  end

  def show
    @plant = Plant.find(params[:id])
    @renting = Renting.new
    @user = current_user
    @plant_user = @plant.user
    if @plant_user.latitude && @plant_user.longitude
      @markers =
        [{
          lat: @plant_user.latitude,
          lng: @plant_user.longitude
        }]
      else
        @markers = []
    end
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
