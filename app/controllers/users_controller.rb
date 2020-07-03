class UsersController < ApplicationController
  def show
    @user = User.new
    @location = Location.new
  end
end
