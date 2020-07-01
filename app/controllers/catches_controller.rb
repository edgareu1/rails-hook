class CatchesController < ApplicationController
  def create
    @catch = Catch.new(catch_params)
    @log = Log.find(params[:log_id])
    @catch.log = @log
    if @catch.save
      redirect_to log_path(@log)
    else
      render 'logs/show'
    end
  end

  private

  def catch_params
    params.require(:catch).permit(:fish_id, :weight)
  end
end
