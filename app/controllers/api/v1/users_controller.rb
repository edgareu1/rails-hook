class Api::V1::UsersController < Api::V1::BaseController
  include PredictionHelper

  before_action :check_user_authorization, only: [ :prediction ]

  def show
    @more_info = authorized_user
    # Only load more complete info if it is that same User making the request
    if @more_info
      @top_fish = @user.top_fish(3)
      @top_locations = @user.top_locations(3)
    end
  end

  def prediction
    num = params[:num].present? ? params[:num].to_i : 3
    @prediction = Predictor.new(@user).top_locations(num)
  end
end
