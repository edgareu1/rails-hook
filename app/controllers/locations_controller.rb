class LocationsController < ApplicationController
   def index
    @locations = current_user.locations
  end

  def show
    @location = current_Location.find(params[:name])
  end

  def destroy
    @location = Location.find(params[:name])
    @location.destroy
  end

  def create
    @location = Location.new(location_params)
    @location.user = current_user
    @location.save
    redirect_to root_path

  end

private

  def location_params
    params.require(:location).permit(:name)
  end
end




#index
#show
#create
#delete
#update
#new (show form to create new location)
#edit (show form to upadte)
