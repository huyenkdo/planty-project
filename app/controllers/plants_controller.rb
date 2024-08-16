class PlantsController < ApplicationController
  before_action :authenticate_user!, only: [:new, :create]
  def index
    @plants = Plant.all

    if params[:query].present?
      @plants = Plant.search_by_name_category_description(params[:query])
    else
      @plants = Plant.all
    end

    if params[:filter].present?
      @plants = @plants.where(category: params[:filter])
    end

    @page = [params[:page].to_i, 1].max
    @per_page = 6
    @total_count = @plants.count
    @total_pages = (@total_count.to_f / @per_page).ceil
    @plants = @plants.offset((@page - 1) * @per_page).limit(@per_page)
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
    @plant = Plant.new(new_params)
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
      redirect_to plant_path(@plant), notice: 'Annonce mise à jour avec succès.'
    else
      render :edit, status: :unprocessable_entity
    end
  end

  def destroy
  end

  private

  def plants_params
    params.require(:plant).permit(:name, :category, :description, :price, :photos)
  end

  def new_params
    params.require(:plant).permit(:name, :category, :description, :price, photos:[])
  end
end
