class Api::V1::PagesController < Api::V1::BaseController
  include PredictionHelper

  acts_as_token_authentication_handler_for User

  before_action :check_user_authorization

  def location_prediction
    location = current_user.locations.find(params[:location_id])

    if location.logs.size < 5
      @prediction = { weather: location.weather_data, prediction: nil }
    else
      @prediction = Ranking.new(current_user).prediction(location)
    end
  end

  def top_prediction
    num = params[:num].present? ? params[:num].to_i : 3

    @prediction = Ranking.new(current_user).top_ranking_locations(num)
  end
end
