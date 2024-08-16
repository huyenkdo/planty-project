class RentingsController < ApplicationController
  before_action :set_renting, only: [:accept, :deny]

  def create
    @renting = Renting.new(renting_params)
    @renting.user = current_user
    plant = Plant.find(params[:plant_id])
    @renting.plant = plant
    @renting.status = 'Demande en attente'

    if @renting.save
      redirect_to plant_path(plant), notice: "Votre demande de réservation a été envoyée avec succès."
    else
      render :new, alert: "Il y a eu un problème avec votre demande de réservation."
    end
  end

  def accept
    if @renting.update!(status: 'Demande acceptée')
      redirect_to dashboard_path, notice: 'La demande a été acceptée'
    else
      redirect_to dashboard_path, alert: 'Il y a eu une erreur'
    end
  end

  def deny

    if @renting.update!(status: 'Demande refusée')
      redirect_to dashboard_path, notice: 'La demande a été refusée'
    else
      redirect_to dashboard_path, alert: 'Il y a eu une erreur'
    end
  end

  private

  def renting_params
    params.require(:renting).permit(:start_date, :end_date)
  end

  def set_renting
    @renting = Renting.find(params[:id])
  end
end
