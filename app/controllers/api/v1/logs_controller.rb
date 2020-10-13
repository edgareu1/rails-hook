class Api::V1::LogsController < Api::V1::BaseController
  before_action :set_user_and_location, only: [ :index, :show, :create ]

  def index
    @logs = @location.logs
  end

  def show
    @log = @location.logs.find(params[:id])
  end

  def create
    @log = @user.logs.new(log_params)
    @log.location = @location

    @log.tag_id = get_tag_id(@location) unless @location.nil?

    if @log.save
      render :show, status: :created
    else
      render_error
    end
  end

  private

  def set_user_and_location
    @user = User.find(params[:user_id])
    @location = @user.locations.find(params[:location_id])
  end

  def log_params
    params.require(:log).permit(:start_time, :end_time, :tag_id, :rating, :observation, :air_pressure, :wind_speed, :moon_phase, :weather_description, :weather_icon)
  end

  def render_error
    render json: { errors: @log.errors.full_messages },
           status: :unprocessable_entity
  end

  # Method that gets the next Log tag_id for a certain location
  def get_tag_id(location)
    location_logs = location.logs

    return location_logs.empty? ? 1 : location_logs.map(&:tag_id).max + 1
  end
end
