class Station < ActiveRecord::Base
  attr_accessible :abbr, :name
  
  #could put get_station_data method here...
end
