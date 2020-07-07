require 'ranking'

class PagesController < ApplicationController
  skip_before_action :authenticate_user!, only: [:home]

  def home
  end

  def ranking
    @ranking = Ranking.new(current_user).rank
    @ranking_hash = @ranking.sort_by { |k, v| v }.reverse
  end
end
