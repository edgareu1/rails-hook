class Api::V1::FishController < Api::V1::BaseController
  def index
    @fish = Fish.all.sort
  end

  def show
    @fish = Fish.find(params[:id])
  end
end
