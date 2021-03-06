class Api::V1::LocationsController < Api::V1::BaseController
  include PredictionHelper

  before_action :check_user_authorization
  before_action :set_location, only: [ :show, :prediction, :update, :destroy ]

  def index
    set_index
  end

  def show
    set_current_weather
  end

  def prediction
    # Get the @prediction variable
    if @location.logs_count < 5
      @prediction = { weather: @location.weather_data, prediction: nil }
    else
      @prediction = Predictor.new(@user).predict(@location)
    end
  end

  def create
    @location = @user.locations.new(location_params)
    # Render
    if @location.save
      set_current_weather
      render :show, status: :created
    else
      render_error
    end
  end

  def update
    # Render
    if @location.update(location_params)
      set_current_weather
      render :show
    else
      render_error
    end
  end

  def destroy
    @location.destroy
    set_index
    render :index
  end

  private

  def location_params
    params.require(:location).permit(:name, :spot)
  end

  def set_location
    @location = @user.locations.find(params[:id] || params[:location_id])
  end

  def set_index
    @locations = @user.locations.sort
  end

  def set_current_weather
    @current_weather = @location.weather_data
  end

  def render_error
    render json: { errors: @location.errors.full_messages },
      status: :unprocessable_entity
  end
end
