class LocationsController < ApplicationController
  def create
    @location = Location.new(location_params)
    @location.user = current_user

    if @location.save
      redirect_to root_path
    else
      render 'users/show'
    end
  end

  private

  def location_params
    params.require(:location).permit(:name, :site)
  end
end
