class FishController < ApplicationController
  def index
    @fish = Fish.all

    if params[:query].present?
      @fish = Fish.where("common_name ILIKE ?", "%#{params[:query]}%")
    else
      @fish = Fish.all
    end

    if @fish.count == 1
      redirect_to fish_path(@fish.first)
    end
  end

  def show
    @fish = Fish.find(params[:id])
  end


end
