class StaticPagesController < ApplicationController
  
  def help
  end

  def contact
    @user = User.new
  end

  def all_stations
  end

  def about
  end
end
