require 'ranking'

class PagesController < ApplicationController
  skip_before_action :authenticate_user!, only: [:home]

  def home
  end

  def ranking
    @top_ranking_hash = Ranking.new(current_user).rank
    @top_ranking_arr = @top_ranking_hash.map { |k, v| [k, v[:classification]] }.sort_by { |k, v| -v }[0..4]
  end
end
