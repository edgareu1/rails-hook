class Api::V1::LogsController < Api::V1::BaseController
  include MoonPhaseHelper

  before_action :check_user_authorization
  before_action :set_log, only: [ :show, :update, :destroy ]

  def index
    @logs = @user.logs.sort
  end

  def location_index
    location = @user.locations.find(params[:location_id])
    @logs = location.logs.sort
  end

  def show
  end

  def create
    @log = @user.logs.new(log_params.except(:temperature, :air_pressure, :wind_speed))

    @log.tag_id = @log.location.next_tag_id unless @user.locations.find(log_params[:location_id]).nil?  # Get the tag_id
    @log.moon_phase = get_moon_phase(@log.start_time)   # Get the moon_phase

    if @log.save
      render :show, status: :created
    else
      render_error
    end
  end

  def update
    @log.attributes = log_params

    if @log.location_id_changed?
      previous_loc_id = @log.location_id_was  # Save the previous Location
      @log.tag_id = @user.locations.find(log_params[:location_id]).next_tag_id  # Get the new tag_id
    end

    @log.moon_phase = get_moon_phase(@log.start_time)   # Get the new moon_phase

    if @log.save
      # If the Logs Location changes, then update the Location catches counters
      if previous_loc_id.present?
        log_counters = Hash[quantity: @log.catches_count, weight: @log.catches_weight]

        Location.find(previous_loc_id).decrement_catches_counters(log_counters)
        @log.location.increment_catches_counters(log_counters)
      end

      render :show
    else
      render_error
    end
  end

  def destroy
    @log.destroy

    @logs = @user.logs.sort
    render :index
  end

  private

  def log_params
    params.require(:log).permit(:start_time, :end_time, :location_id, :rating, :observation, :temperature, :air_pressure, :wind_speed)
  end

  def set_log
    @log = @user.logs.find(params[:id])
  end

  def render_error
    render json: { errors: @log.errors.full_messages },
           status: :unprocessable_entity
  end
end
