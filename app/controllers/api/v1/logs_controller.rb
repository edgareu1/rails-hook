class Api::V1::LogsController < Api::V1::BaseController
  before_action :set_user_and_location, only: [ :index, :show ]

  def index
    @logs = @location.logs
  end

  def show
    @log = @location.logs.find(params[:id])
  end

  private

  def set_user_and_location
    user = User.find(params[:user_id])
    @location = user.locations.find(params[:location_id])
  end
end
