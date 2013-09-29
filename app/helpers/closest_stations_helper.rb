module ClosestStationsHelper
    GOOGLE_API_KEY = ENV["GOOGLE_API_KEY"]
  
    def get_nearest_stations(user_position)
       stations_query = Addressable::URI.new(
         :scheme => "https",
         :host => "maps.googleapis.com",
         :path => "maps/api/place/nearbysearch/json",
         :query_values => {
           :key => GOOGLE_API_KEY,
           :location => user_position,
           :rankby => "distance",
           :sensor => false,
           :types => "train_station",
           :keyword => "Bart Station" 
          })
          
      stations_response = HTTParty.get(stations_query).to_json
      JSON.parse(stations_response)['results']
    end
   
end
