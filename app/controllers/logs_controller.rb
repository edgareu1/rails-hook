class LogsController < ApplicationController
  before_action :set_log, only: [:show, :update, :destroy]

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
    @catch = Catch.new
  end

  def update
    @log.update(log_params)

    redirect_to log_path(@log)
  end

  def destroy
    @log.destroy

    redirect_to logs_path
  end

  private

  def log_params
    params.require(:log).permit(:start_time, :end_time, :rating, :observation, :location_id)
  end

  def set_log
    @log = Log.find(params[:id])
  end
end
