class RentingsController < ApplicationController
  def create
    @renting = Renting.new(renting_params)
    @renting.user = current_user
    plant = Plant.find(params[:plant_id])
    @renting.plant = plant

    if @renting.save
      redirect_to plant_path(plant), notice: "Votre demande de réservation a été envoyée avec succès."
    else
      render :new, alert: "Il y a eu un problème avec votre demande de réservation."
    end
  end

  private

  def renting_params
    params.require(:renting).permit(:start_date, :end_date)
  end
end
