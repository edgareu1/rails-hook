class Api::V1::PagesController < Api::V1::BaseController
  include PredictionHelper

  before_action :check_user_authorization

  def location_prediction
    location = @user.locations.find(params[:location_id])

    if location.logs_count < 5
      @prediction = { weather: location.weather_data, prediction: nil }
    else
      @prediction = Predictor.new(@user).predict(location)
    end
  end

  def top_prediction
    num = params[:num].present? ? params[:num].to_i : 3

    @prediction = Predictor.new(@user).top_locations(num)
  end
end
