class PagesController < ApplicationController
  include PredictionHelper

  def prediction
    @prediction = Ranking.new(current_user).top_ranking_locations(3)
  end

  def location_prediction
    location = current_user.locations.find(params[:location_id])

    if location.logs.size < 5
      @prediction =  nil
    else
      @prediction = Ranking.new(current_user).prediction(location)
    end
  end
end
