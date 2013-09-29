class ClosestStationsController < ApplicationController
  
  def create
    lat = params[:latitude].to_s
    long = params[:longitude].to_s
    latlong = lat + "," + long
    #render json: {"position" => "#{latlong}"}
    render json: get_nearest_stations(latlong)
  end
end
