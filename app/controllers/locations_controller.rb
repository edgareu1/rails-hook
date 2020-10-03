class LocationsController < ApplicationController
  def create
    @location = current_user.locations.new(location_params)

    @user_locations = current_user.locations if @location.save
  end

  private

  def location_params
    params.require(:location).permit(:name, :site)
  end
end
