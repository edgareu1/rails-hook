class Api::V1::LogsController < Api::V1::BaseController
  include MoonPhaseHelper

  before_action :check_user_authorization
  before_action :set_location, only: [ :location_index ]
  before_action :set_log,      only: [ :show, :update, :destroy ]

  def index
    set_index
  end

  def location_index
    @logs = @location.logs.sort
  end

  def show
  end

  def create
    # Create a new Log, and set the tag_id and moon_phase attributes
    @log = @user.logs.new(
      log_params.except(:temperature, :air_pressure, :wind_speed)
    )
    @log.tag_id = @user.locations.find(log_params[:location_id]).next_tag_id
    @log.moon_phase = get_moon_phase(@log.start_time)
    # Render
    if @log.save
      render :show, status: :created
    else
      render_error
    end
  end

  def update
    @log.attributes = log_params
    # If the Log Location changed, then get the new tag_id
    if @log.location_id_changed?
      previous_loc_id = @log.location_id_was
      @log.tag_id = @user.locations.find(log_params[:location_id]).next_tag_id
    end
    @log.moon_phase = get_moon_phase(@log.start_time)
    # Render
    if @log.save
      # If the Log Location changed, then update the Location catch counters
      if previous_loc_id.present?
        log_counters = Hash[
          quantity: @log.catches_count,
          weight: @log.catches_weight
        ]
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
    set_index
    render :index
  end

  private

  def log_params
    params.require(:log).permit(
      :start_time,
      :end_time,
      :location_id,
      :rating,
      :observation,
      :temperature,
      :air_pressure,
      :wind_speed
    )
  end

  def set_log
    @log = @user.logs.find(params[:id])
  end

  def set_location
    @location = @user.locations.find(params[:location_id])
  end

  def set_index
    @logs = @user.logs.sort
  end

  def render_error
    render json: { errors: @log.errors.full_messages },
      status: :unprocessable_entity
  end
end
