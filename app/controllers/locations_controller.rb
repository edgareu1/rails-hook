class LocationsController < ApplicationController
   def index
    @locations = current_user.locations
  end

  def show
    @location = current_Location.find(params[:id])
  end

  def destroy
    @location = Location.find(params[:id])
    @location.destroy
  end

  def create
    @location = Location.new(location_params)
    @location.user = current_user
    @location.save

    redirect_to root_path
  end

private

  def location_params
    params.require(:location).permit(:name, :site)
  end
end
