class Api::V1::LogsController < Api::V1::BaseController
  before_action :check_user_authorization
  before_action :set_log, only: [ :show, :update, :destroy ]

  def index
    @logs = @user.logs.sort
  end

  def location_index
    @location = @user.locations.find(params[:location_id])
    @logs = @location.logs.sort
  end

  def show
  end

  def create
    @log = @user.logs.new(log_params)

    @log.tag_id = @log.location.next_tag_id unless @log.location.nil?

    if @log.save
      render :show, status: :created
    else
      render_error
    end
  end

  def update
    if @log.update(log_params)
      render :show
    else
      render_error
    end
  end

  def destroy
    @log.destroy
  end

  private

  def log_params
    params.require(:log).permit(:start_time, :end_time, :location_id, :rating, :observation, :temperature, :air_pressure, :wind_speed, :moon_phase, :weather_description, :weather_icon)
  end

  def set_log
    @log = @user.logs.find(params[:id])
  end

  def render_error
    render json: { errors: @log.errors.full_messages },
           status: :unprocessable_entity
  end
end
