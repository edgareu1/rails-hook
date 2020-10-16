class LocationsController < ApplicationController
  include ApplicationHelper
  include MoonPhaseHelper

  before_action :set_location, only: [:show, :update, :destroy]

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
    if @location.nil? || @location.user != current_user
      flash[:alert] = "That Location was not found"
      redirect_to locations_path

    else
      weather_data = @location.fetch_weather_data

      @location_weather = {
        icon: weather_data["weather"].first["icon"],
        description: weather_data["weather"].first["description"],
        air_pressure: weather_data["main"]["pressure"],
        wind_speed: weather_data["wind"]["speed"],
        temperature: kelvin_to_celcius(weather_data["main"]["temp"]).round(1),
        moon_phase: (get_moon_phase(Time.now) * 100).round
      }
    end
  end

  def update
    @location.update(location_params)
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
end
