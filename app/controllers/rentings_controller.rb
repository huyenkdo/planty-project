class RentingsController < ApplicationController
  before_action :set_renting, only: [:accept, :deny]

  def create
  end

  def accept
    if @renting.update!(status: 'Demande acceptée')
      redirect_to dashboard_path, notice: 'La demande a été acceptée'
    else
      redirect_to dashboard_path, alert: 'Il y a eu une erreur'
    end
  end

  def deny
    if @renting.update(status: 'Demande refusée')
      redirect_to dashboard_path, notice: 'La demande a été refusée'
    else
      redirect_to dashboard_path, alert: 'Il y a eu une erreur'
    end
  end

  private

  def set_renting
    @renting = Renting.find(params[:id])
  end
end
