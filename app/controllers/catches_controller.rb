class CatchesController < ApplicationController
  before_action :set_log, only: [:create, :destroy]

  def create
    @catch = @log.catches.create(catch_params)
  end

  def destroy
    @catch = Catch.find(params[:id])
    @catch.destroy
  end

  private

  def catch_params
    params.require(:catch).permit(:fish_id, :quantity, :weight)
  end

  def set_log
    @log = Log.find(params[:log_id])
  end
end
