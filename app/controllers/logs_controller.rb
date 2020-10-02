require 'will_paginate/array'

class LogsController < ApplicationController
  include MoonPhaseHelper

  before_action :set_log, only: [:show, :update, :destroy]

  def create
    @log = Log.new(log_params_new)
    @log.user = current_user
    @log.tag_id = get_tag_id(@log.location) unless @log.location.nil?

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
    start_error = params[:log][:start_time].blank?
    new_start_time = start_error ? @log.start_time : DateTime.parse(params[:log][:start_time])

    end_error = params[:log][:end_time].blank?
    new_end_time = end_error ? @log.end_time : DateTime.parse(params[:log][:end_time])

    new_moon_phase = get_moon_phase(new_start_time)

    param_location_id = params[:log][:location_id].to_i
    new_tag_id = @log.location_id == param_location_id ? @log.location_id : get_tag_id(Location.find(param_location_id))

    successful_update = @log.update(
      tag_id:       new_tag_id,
      start_time:   new_start_time,
      end_time:     new_end_time,
      moon_phase:   new_moon_phase,
      location_id:  params[:log][:location_id],
      air_pressure: params[:log][:air_pressure],
      wind_speed:   params[:log][:wind_speed],
      observation:  params[:log][:observation],
      rating:       params[:log][:rating]
    )

    @log.errors.add(:end_time, "Log has to have a start time") if start_error
    @log.errors.add(:end_time, "Log has to have a end time")   if end_error
  end

  def destroy
    @log.destroy

    redirect_to logs_path
  end

  private

  def log_params_new
    params.require(:log).permit(:start_time, :end_time, :rating, :observation, :location_id)
  end

  def set_log
    @log = Log.find(params[:id])
  end

  # Gets the next tag_id for a Log of a certain location
  def get_tag_id(location)
    location_logs = location.logs

    return location_logs.empty? ? 1 : location_logs.map(&:tag_id).max + 1
  end

  # Gets the collection of Logs to display at the Logs#index Page
  def init_logs_index(user)
    return user.logs
               .sort_by(&:start_time)
               .reverse.paginate(page: params[:page], per_page: 5)
  end
end
