class RestaurantsController < ApplicationController
  def index
    if(current_user)
    	@restaurants = Restaurant.all
    else
    	redirect_to root_path
    end
  end

  def show
    @restaurant = Restaurant.find(params[:id])
  end
end
