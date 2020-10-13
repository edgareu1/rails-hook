require 'will_paginate/array'

class LogsController < ApplicationController
  include MoonPhaseHelper

  before_action :set_log, only: [:show, :update, :destroy]

  def create
    @log = current_user.logs.new(log_params)
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
    # Get the new start_time
    start_error = params[:log][:start_time].blank?
    new_start_time = start_error ? @log.start_time : DateTime.parse(params[:log][:start_time])

    # Get the new end_time
    end_error = params[:log][:end_time].blank?
    new_end_time = end_error ? @log.end_time : DateTime.parse(params[:log][:end_time])

    # Get the new moon_phase
    new_moon_phase = get_moon_phase(new_start_time)

    # Get the new tag_id if the Location does change
    param_location_id = params[:log][:location_id].to_i
    new_tag_id = ( @log.location_id == param_location_id ? @log.location_id : Location.find(param_location_id).next_tag_id )

    @log.update(
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

    # Add 'presence: true' validation errors to the start/end_time fields if they do exist
    @log.errors.add(:end_time, "Log has to have a start time") if start_error
    @log.errors.add(:end_time, "Log has to have a end time")   if end_error
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
    @log = Log.find_by(id: params[:id])
  end
end
