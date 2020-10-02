class LocationsController < ApplicationController
  def create
    @location = Location.new(location_params)
    @location.user = current_user

    @user_locations = current_user.locations if @location.save
  end

  private

  def location_params
    params.require(:location).permit(:name, :site)
  end
end
