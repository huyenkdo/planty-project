class PlantsController < ApplicationController
  def index
    @plants = Plant.all
  end

  def show
    @plants = Plant.new
  end

  def new
  end

  def create
  end

  def edit
  end

  def update
  end

  def destroy
  end
end
