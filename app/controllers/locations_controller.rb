class LocationsController < ApplicationController
  include ApplicationHelper
  include MoonPhaseHelper

  def create
    @location = current_user.locations.new(location_params)

    @user_locations = current_user.locations if @location.save
  end

  def index
    @locations = current_user.locations
                             .order(logs_count: :desc)
                             .paginate(page: params[:page], per_page: 5)
  end

  def show
    @location = Location.find_by(id: params[:id])

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

  private

  def location_params
    params.require(:location).permit(:name, :spot)
  end
end
