class PagesController < ApplicationController
  include PredictionHelper

  def prediction
    @prediction = Ranking.new(current_user).top_ranking_locations(3)
  end

  def location_prediction
    location = current_user.locations.find(params[:location_id])
    @prediction = Ranking.new(current_user).prediction(location)[:prediction]
  end
end
