class Api::V1::UsersController < Api::V1::BaseController
  def show
    @user = User.find(params[:id])

    # If the request comes from that same User, then display more complete info
    @more_info = (current_user == @user)

    # Only load the more complete info if necessary
    if @more_info
      @top_fish = @user.top_fish(3)
      @top_locations = @user.top_locations(3)
    end
  end
end
