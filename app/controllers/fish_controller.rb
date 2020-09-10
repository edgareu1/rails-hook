class FishController < ApplicationController
  def index
    @fish = Fish.all

    # Add the gem 'gon' in order to be able to call this variable from the JS variable
    # 'fishNames' in the JS funtion 'autoCompleteFish'
    gon.fish_names = @fish.map(&:common_name)
                          .join(', ')

    # Option to search a fish by it's name
    if params[:query].present?
      @fish = Fish.where("common_name ILIKE ?", "%#{params[:query]}%")
    else
      @fish = Fish.all
    end

    # For the AJAX requests
    respond_to do |format|
      format.html
      format.js
    end
  end

  def show
    @fish = Fish.find(params[:id])
  end
end
