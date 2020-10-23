class PagesController < ApplicationController
  include PredictionHelper

  def prediction
    @prediction = Predictor.new(current_user).top_locations(3)
  end

  def location_prediction
    location = current_user.locations.find(params[:location_id])
    @prediction = Predictor.new(current_user).predict(location)[:prediction]
  end
end
