class StationsController < ApplicationController
  include StationsHelper
  
  
  def index
    @stations = Station.all
    render :index
  end
  
  def show
    @station = Station.find(params[:id])
    respond_to do |format| 
      format.html { render :show }
      format.json { render json: get_station_data(@station.abbr) }
    end
  end
  
end
