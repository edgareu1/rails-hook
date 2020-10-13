class Api::V1::LocationsController < Api::V1::BaseController
  before_action :set_user, only: [ :index, :show, :create ]

  def index
    @locations = @user.locations
  end

  def show
    @location = @user.locations.find(params[:id])
  end

  def create
    @location = @user.locations.new(location_params)

    if @location.save
      render :show, status: :created
    else
      render_error
    end
  end

  private

  def location_params
    params.require(:location).permit(:name, :spot)
  end

  def set_user
    @user = User.find(params[:user_id])
  end

  def render_error
    render json: { errors: @location.errors.full_messages },
           status: :unprocessable_entity
  end
end
