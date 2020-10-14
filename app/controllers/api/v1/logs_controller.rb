class Api::V1::LogsController < Api::V1::BaseController
  acts_as_token_authentication_handler_for User

  before_action :check_user_authorization

  before_action :set_user_and_location, only: [ :index, :show, :create, :update, :destroy ]
  before_action :set_log,               only: [ :update, :destroy ]

  def index
    @logs = @location.logs.sort
  end

  def show
    @log = @location.logs.find(params[:id])
  end

  def create
    @log = @user.logs.new(log_params)
    @log.location = @location

    @log.tag_id = @location.next_tag_id unless @location.nil?

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
    params.require(:log).permit(:start_time, :end_time, :rating, :observation, :air_pressure, :wind_speed, :moon_phase, :weather_description, :weather_icon)
  end

  def set_user_and_location
    @user = User.find(params[:user_id])
    @location = @user.locations.find(params[:location_id])
  end

  def set_log
    @log = @location.logs.find(params[:id])
  end

  def render_error
    render json: { errors: @log.errors.full_messages },
           status: :unprocessable_entity
  end
end
