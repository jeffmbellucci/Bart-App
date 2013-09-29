class ClosestStationsController < ApplicationController
  
  def create
    lat = params[:latitude].to_s
    long = params[:longitude].to_s
    user_coords = lat + "," + long
    
    render json: get_nearest_stations(user_coords)
  end
end
