require 'ranking'

class PagesController < ApplicationController
  skip_before_action :authenticate_user!, only: [:home]

  def prediction
    @prediction = Ranking.new(current_user).top_ranking_locations(3)
  end
end
