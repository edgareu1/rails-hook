class LocationsController < ApplicationController
  include ApplicationHelper
  include MoonPhaseHelper

  before_action :set_location, only: [ :show, :update, :destroy ]

  def create
    @location = current_user.locations.new(location_params)

    redirect_to location_path(@location) if @location.save
  end

  def index
    @locations = current_user.locations
                             .order(logs_count: :desc)
                             .paginate(page: params[:page], per_page: 5)
  end

  def show
    if @location.nil? || current_user != @location.user
      flash[:alert] = "Location was not found"
      redirect_to locations_path

    else
      get_location_weather
    end
  end

  def update
    @location.attributes = location_params
    name_changed = @location.name_changed? # If the Location does change refresh the weather
    @location.save

    get_location_weather if name_changed
  end

  def destroy
    @location.destroy

    redirect_to locations_path
  end

  private

  def location_params
    params.require(:location).permit(:name, :spot)
  end

  def set_location
    @location = Location.find_by(id: params[:id])
  end

  def get_location_weather
    weather_data = @location.fetch_weather_data

    @location_weather = {
      icon:         weather_data["weather"].first["icon"],
      description:  weather_data["weather"].first["description"],
      air_pressure: weather_data["main"]["pressure"],
      wind_speed:   weather_data["wind"]["speed"],
      temperature:  kelvin_to_celcius(weather_data["main"]["temp"]).round(1),
      moon_phase:   (get_moon_phase(Time.now) * 100).round
    }
  end
end
