class UsersController < ApplicationController
  def show
    @location = Location.new
  end
end
