class LocationsController < ApplicationController
   def index
    @locations = Location.all
  end

  def show
    @location = Location.find(params[:id])
  end

  def destroy
    @location = Location.find(params[:id])
    @location.destroy
  end

  def create
    @location = Location.new

  end


end




#index
#show
#create
#delete
#update
#new (show form to create new location)
#edit (show form to upadte)
