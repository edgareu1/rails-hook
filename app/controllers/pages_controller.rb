class PagesController < ApplicationController
  skip_before_action :authenticate_user!, only: [:home]

  def home
  end

  def ranking
    # An hash with locations and stuff
    ranking = Ranking.new(current_user).rank
  end
end
