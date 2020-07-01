class LogsController < ApplicationController
  def new
    @log = Log.new
  end

  def create
    @log = Log.new(log_params)
    @log.user = current_user

    if @log.save
      redirect_to log_path(@log)
    else
      render 'logs/new'
    end
  end

  def show
    @log = Log.find(params[:id])
    @catch = Catch.new
  end

  private

  def log_params
    params.require(:log).permit(:start_time, :end_time, :rating, :observation, :location_id)
  end
end
