class PlantsController < ApplicationController
  def index
    @plants = Plant.all
    if params[:filter].present?
      @plants = @plants.where(category: params[:filter])
    end
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
    @plant.user = current_user
    if @plant.save
      redirect_to plant_path(@plant), notice: 'La plante a été créée avec succès.'
    else
      render :new, status: :unprocessable_entity
    end
  end

  def edit
    @plant = Plant.find(params[:id])
  end

  def update
    @plant = Plant.find(params[:id])
    if @plant.update(plants_params)
      redirect_to @plant, notice: 'Annonce mise à jour avec succès.'
    else
      render :edit, status: :unprocessable_entity
    end
  end

  def destroy
  end

  private

  def plants_params
    params.require(:plant).permit(:name, :category, :description, :price, photos: [])
  end
end
