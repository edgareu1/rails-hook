class FishController < ApplicationController
  def index
    # Option to search a fish by it's name
    @fish = params[:query].present? ? Fish.where("common_name ILIKE ?", "%#{params[:query]}%") : Fish.all

    # Add the gem 'gon' in order to be able to call this variable from the JS variable
    # 'fishNames' in the JS funtion 'autoCompleteFish'
    gon.fish_names = @fish.map(&:common_name).join(', ')
  end

  def show
    @fish = Fish.find_by(id: params[:id])

    redirect_to fish_index_path if @fish.nil?
  end
end
