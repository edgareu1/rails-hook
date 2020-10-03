class PagesController < ApplicationController
  include PredictionHelper

  def prediction
    @prediction = Ranking.new(current_user).top_ranking_locations(3)
  end
end
