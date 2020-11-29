class LocationsController < ApplicationController
  class NonExistentNameError < StandardError; end

  require 'will_paginate/array'
  include PredictionHelper

  before_action :set_location, only: [ :show, :prediction, :update, :destroy ]

  def index
    @locations = current_user.locations
                             .sort_by { |loc| [loc.catches_weight, loc.created_at] }
                             .reverse
                             .paginate(page: params[:page], per_page: 5)
  end

  def show
    if @location.nil?
      flash[:alert] = "Location was not found"
      redirect_to locations_path
    else
      @location_weather = @location.weather_data
    end
  end

  def prediction
    @prediction = Predictor.new(current_user).predict(@location)[:prediction]
  end

  def create
    @location = current_user.locations.new(location_params)

    redirect_to location_path(@location) if @location.save
  end

  def update
    @location.update(location_params)
    @location_weather = @location.weather_data
  end

  def destroy
    @location.destroy
    redirect_to locations_path
  end

  private

  def location_params
    params.require(:location).permit(:name, :spot)
  end

  def set_location
    @location = current_user.locations.find_by(id: params[:id] || params[:location_id])
  end
end
