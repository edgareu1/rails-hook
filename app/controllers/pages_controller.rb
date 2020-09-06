require 'ranking'

class PagesController < ApplicationController
  skip_before_action :authenticate_user!, only: [:home]

  def prediction
    @all_location_stat_hash = Ranking.new(current_user).rank
    @top_3_locations = @all_location_stat_hash.delete_if { |k, v| v[:classification].zero? || (v[:num_predicted_per_hour] * 5).round.zero? || (v[:gr_predicted_per_hour] * 5).round.zero? }.map { |k, v| [k, v[:classification]] }.sort_by { |k, v| -v }[0..2]
  end
end
