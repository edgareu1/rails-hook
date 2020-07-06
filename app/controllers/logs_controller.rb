class LogsController < ApplicationController
  before_action :set_log, only: [:show, :update, :destroy]

  def create
    @log = Log.new(log_params)
    @log.user = current_user

    logs_same_location = current_user.logs.to_a.select { |log| log.location == @log.location }

    if logs_same_location.empty?
      @log.tag_id = 1
    else
      @log.tag_id = logs_same_location.max_by { |element| element.tag_id }.tag_id + 1
    end

    weather_data = Rails.configuration.open_weather_api.current lon: @log.location.longitude , lat: @log.location.latitude

    @log.air_pressure = weather_data["main"]["pressure"]
    @log.wind_speed = weather_data["wind"]["speed"]
    @log.weather_icon = weather_data["weather"][0]["icon"]
    @log.weather_description = weather_data["weather"][0]["description"]

    if @log.save
      redirect_to log_path(@log)
    else
      @logs = current_user.logs
      render :index
    end
  end

  def index
    @log = Log.new
    @logs = current_user.logs
  end

  def show
    @catch = Catch.new
  end

  def update
    @log.update(log_params)

    redirect_to log_path(@log)
  end

  def destroy
    @log.destroy

    redirect_to logs_path
  end

  private

  def log_params
    params.require(:log).permit(:start_time, :end_time, :rating, :observation, :location_id)
  end

  def set_log
    @log = Log.find(params[:id])
  end
end
