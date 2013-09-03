class StationsController < ApplicationController
  include StationsHelper
  
  
  def index
    @stations = Station.all
  end
  
  def show
    @station = Station.find(params[:id])
  end
  
end
