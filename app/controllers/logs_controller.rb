require 'will_paginate/array'

class LogsController < ApplicationController
  before_action :set_log, only: [:show, :update, :destroy]


  def create
    @log = Log.new(log_params_new)
    @log.user = current_user
    @log.tag_id = get_tag_id(@log) unless @log.location.nil?

    if @log.save
      redirect_to log_path(@log)
    else
      @logs = current_user.logs.to_a.sort_by { |log| log["start_time"] }.reverse.paginate(page: params[:page], per_page: 5)
      render :index
    end
  end


  def index
    @log = Log.new
    @logs = current_user.logs.to_a.sort_by { |log| log["start_time"] }.reverse.paginate(page: params[:page], per_page: 5)
  end


  def show
    @catch = Catch.new
  end


  def update
    logs_same_location = current_user.logs.to_a.select { |log| log.location == Location.find(params["log"]["location_id"]) }

    if logs_same_location.empty?
      @log.update(tag_id: 1)

    elsif @log.location != Location.find(params["log"]["location_id"])
      max_tag = logs_same_location.max_by { |element| element.tag_id }.tag_id
      @log.update(tag_id: max_tag + 1)
    end

    @log.update(log_params_edit)

    @log.update(moon_phase: moon_calculation(@log.start_time, @log.end_time))

    redirect_to log_path(@log)
  end


  def destroy
    @log.destroy

    redirect_to logs_path
  end


  private

  # A num based on the tag_id of the last log with the same location
  def get_tag_id(log)
    location_logs = log.location.logs

    return location_logs.empty? ? 1 : location_logs.map(&:tag_id).max + 1
  end

  def moon_calculation(start_time, end_time)
    new_moon_base = Time.new(2020, 06, 21, 6, 41, 00)
    moon_cycle = 29.5 * 60 * 60 * 24
    average_time = start_time + ((end_time - start_time) / 2)

    time_past_new_moon = (average_time - new_moon_base) % moon_cycle
    moon_percentage = (time_past_new_moon / moon_cycle)

    if moon_percentage < 0.5
      return moon_percentage * 2
    else
      return (1 - moon_percentage) * 2
    end
  end


  def log_params_new
    params.require(:log).permit(:start_time, :end_time, :rating, :observation, :location_id)
  end


  def log_params_edit
    params.require(:log).permit(:start_time, :end_time, :rating, :observation, :location_id, :air_pressure, :wind_speed)
  end


  def set_log
    @log = Log.find(params[:id])
  end
end
