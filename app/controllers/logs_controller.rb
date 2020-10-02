require 'will_paginate/array'

class LogsController < ApplicationController
  include MoonPhaseHelper

  before_action :set_log, only: [:show, :update, :destroy]

  def create
    @log = Log.new(log_params_new)
    @log.user = current_user
    @log.tag_id = get_tag_id(@log) unless @log.location.nil?

    if @log.save
      redirect_to log_path(@log)
    else
      @logs = init_logs_index(current_user)
      render "logs/index"
    end
  end

  def index
    @logs = init_logs_index(current_user)
  end

  def show
    @catch = Catch.new
  end

  def update
    previous_location_id = @log.location_id

    successful_update = @log.update(log_params_edit)
    @log.update(moon_phase: get_moon_phase(@log.start_time))

    unless previous_location_id == @log.location_id
      # In order to not count this same tag_id in the calculation of the new tag_id
      @log.update(tag_id: 0)
      @log.update(tag_id: get_tag_id(@log))
    end

    if successful_update
      redirect_to log_path(@log)
    else
      @catch = Catch.new
      render "logs/show"
    end
  end

  def destroy
    @log.destroy

    redirect_to logs_path
  end

  private

  def log_params_new
    params.require(:log).permit(:start_time, :end_time, :rating, :observation, :location_id)
  end

  def log_params_edit
    params.require(:log).permit(:start_time, :end_time, :rating, :observation, :location_id, :air_pressure, :wind_speed)
  end

  def set_log
    @log = Log.find(params[:id])
  end

  # Gets the next tag_id for a Log of a certain location
  def get_tag_id(log)
    location_logs = log.location.logs

    return location_logs.empty? ? 1 : location_logs.map(&:tag_id).max + 1
  end

  # Gets the collection of Logs to display at the Logs#index Page
  def init_logs_index(user)
    return user.logs
               .sort_by(&:start_time)
               .reverse.paginate(page: params[:page], per_page: 5)
  end
end
