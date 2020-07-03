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
      render 'logs'
    end
  end

  def index
    @logs = current_user.logs
  end

  def show
    @log = Log.find(params[:id])
    @catch = Catch.new
  end

  def update
    @log = Log.find(params[:id])
    @log.update(log_params)

    redirect_to log_path(@log)
  end

  def destroy
    @log = Log.find(params[:id])
    @log.destroy

    redirect_to new_log_path
  end

  private

  def log_params
    params.require(:log).permit(:start_time, :end_time, :rating, :observation, :location_id)
  end
end
