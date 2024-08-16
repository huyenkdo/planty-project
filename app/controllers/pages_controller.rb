class PagesController < ApplicationController
  before_action :authenticate_user!, only: :dashboard
  def home
  end

  def dashboard
    @user = current_user
    @own_plants = @user.plants
    @rentings = @user.rentings
  end
end
