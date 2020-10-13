class Api::V1::LocationsController < Api::V1::BaseController
  before_action :set_user, only: [ :index, :show ]

  def index
    @locations = @user.locations
  end

  def show
    @location = @user.locations.find(params[:id])
  end

  private

  def set_user
    @user = User.find(params[:user_id])
  end
end
