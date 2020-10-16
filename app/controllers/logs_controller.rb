require 'will_paginate/array'

class LogsController < ApplicationController
  include MoonPhaseHelper

  before_action :set_log, only: [:show, :update, :destroy]

  def create
    @log = current_user.logs.new(log_params.except(:air_pressure, :wind_speed))
    @log.tag_id = @log.location.next_tag_id unless @log.location.nil?

    redirect_to log_path(@log) if @log.save
  end

  def index
    @logs = current_user.logs
                        .order(start_time: :desc)
                        .paginate(page: params[:page], per_page: 5)
  end

  def show
    if @log.nil? || @log.user != current_user
      flash[:alert] = "That Log was not found"
      redirect_to logs_path
    end
  end

  def update
    @log.attributes = log_params

    # Get the new start_time
    if @log.start_time.blank?
      @log.start_time = @log.start_time_was
      start_time_error = true
    end

    # Get the new end_time
    if @log.end_time.blank?
      @log.end_time = @log.end_time_was
      end_time_error = true
    end

    # Get the new moon_phase
    @log.moon_phase = get_moon_phase(@log.start_time)

    # Get the new tag_id if the Location does change
    @log.tag_id = @log.location.next_tag_id if @log.location_id_changed?

    @log.save

    # Add the Time related errors
    @log.errors.add(:end_time, "Log has to have a start time") if start_time_error
    @log.errors.add(:end_time, "Log has to have a end time")   if end_time_error
  end

  def destroy
    @log.destroy

    redirect_to logs_path
  end

  private

  def log_params
    params.require(:log).permit(:start_time, :end_time, :rating, :observation, :location_id, :air_pressure, :wind_speed)
  end

  def set_log
    @log = Log.find_by(id: params[:id])
  end
end
