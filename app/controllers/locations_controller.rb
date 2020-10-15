class LocationsController < ApplicationController
  include ApplicationHelper

  def create
    @location = current_user.locations.new(location_params)

    @user_locations = current_user.locations if @location.save
  end

  def index
    @locations = current_user.locations
                             .order(logs_count: :desc)
                             .map(&:data_to_display)
                             .paginate(page: params[:page], per_page: 5)
  end

  private

  def location_params
    params.require(:location).permit(:name, :spot)
  end
end
