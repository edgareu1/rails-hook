class FishController < ApplicationController
  def index
    # Option to search a fish by it's name
    @fish = params[:query].present? ? Fish.where("name ILIKE ?", "%#{params[:query]}%") : Fish.all
    @fish = @fish.sort_by(&:name)

    # Add the gem 'gon' in order to be able to call this variable from the JS variable
    # 'fishNames' in the JS funtion 'autoCompleteFish'
    gon.fish_names = @fish.map(&:name).join(', ')
  end

  def show
    @fish = Fish.find_by(id: params[:id])

    if @fish.nil?
      flash[:alert] = "That Fish was not found"
      redirect_to fish_index_path
    end
  end
end
