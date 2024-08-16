class PagesController < ApplicationController
  before_action :authenticate_user!, only: :dashboard
  def home
  end

  def dashboard
    @user = current_user
    @own_plants = @user.plants
    @rentings = @user.rentings
    @requests = []
    @own_plants.each do |plant|
      @requests << plant.rentings
    end
  end
end
