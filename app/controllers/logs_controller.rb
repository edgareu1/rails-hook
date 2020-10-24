require 'will_paginate/array'

class LogsController < ApplicationController
  include MoonPhaseHelper

  before_action :set_location, only: [ :location_index ]
  before_action :set_log,      only: [ :show, :update, :destroy ]

  def index
    @logs = current_user.logs
                        .order(start_time: :desc)
                        .paginate(page: params[:page], per_page: 5)
  end

  def location_index
    if @location.nil?
      flash[:alert] = "Location was not found"
      redirect_to locations_path

    else
      @logs = @location.logs
                       .order(start_time: :desc)
                       .paginate(page: params[:page], per_page: 5)
    end
  end

  def show
    if @log.nil?
      flash[:alert] = "Log was not found"
      redirect_to logs_path
    end
  end

  def create
    @log = current_user.logs.new(log_params.except(:temperature, :air_pressure, :wind_speed))
    @log.tag_id = @log.location.next_tag_id unless @log.location.nil?

    redirect_to log_path(@log) if @log.save

    get_time_errors
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

    @log.moon_phase = get_moon_phase(@log.start_time)   # Get the new moon_phase

    if @log.location_id_changed?
      previous_loc_id = @log.location_id_was    # Save the previous Location
      @log.tag_id = @log.location.next_tag_id   # Get the new tag_id
    end

    # If the Logs Location changes, then update the Locations catches counters
    if @log.save && previous_loc_id.present?
      log_counters = Hash[quantity: @log.catches_count, weight: @log.catches_weight]

      Location.find(previous_loc_id).decrement_catches_counters(log_counters)
      @log.location.increment_catches_counters(log_counters)
    end

    # Add Time related errors
    @log.errors.add(:start_time, "must exist") if start_time_error
    @log.errors.add(:end_time, "must exist")   if end_time_error

    get_time_errors
  end

  def destroy
    @log.destroy

    redirect_to logs_path
  end

  private

  def log_params
    params.require(:log).permit(:start_time, :end_time, :location_id, :rating, :observation, :temperature, :air_pressure, :wind_speed)
  end

  def set_log
    @log = current_user.logs.find_by(id: params[:id])
  end

  def set_location
    @location = current_user.locations.find_by(id: params[:location_id])
  end

  def get_time_errors
    @time_errors = @log.errors.messages
                              .slice(:start_time, :end_time, :duration)
                              .map { |k, v| k.to_s.humanize + " " +  v.first }
  end
end
