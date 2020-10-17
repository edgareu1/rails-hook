class Api::V1::UsersController < Api::V1::BaseController
  def show
    @user = User.find(params[:id])

    # If the request comes from that same User, then display more complete info
    @more_info = request.headers["X-User-Email"] == @user.email &&
                 request.headers["X-User-Token"] == @user.authentication_token

    # Only load the more complete info if necessary
    if @more_info
      @top_fish = @user.top_fish(3)
      @top_locations = @user.top_locations(3)
    end
  end
end
