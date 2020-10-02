class CatchesController < ApplicationController
  before_action :set_log, only: [:create, :destroy]

  def create
    @catch = Catch.new(catch_params)
    @catch.log = @log

    @catch.save
  end

  def destroy
    @catch = Catch.find(params[:id])
    @catch.destroy

    redirect_to log_path(@log)
  end

  private

  def catch_params
    params.require(:catch).permit(:fish_id, :quantity, :weight)
  end

  def set_log
    @log = Log.find(params[:log_id])
  end
end
