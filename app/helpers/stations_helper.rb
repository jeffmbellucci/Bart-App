module StationsHelper
  API_KEY = 'Q5K4-2SIW-TMRY-8U3Z'
  
  def get_station_data(abbr)
    bart_query = Addressable::URI.new(
      scheme: "http",
      host: "api.bart.gov",
      path: "api/etd.aspx",
      query_values: {
        cmd: "etd",
        orig: abbr,
        key: API_KEY 
        }).to_s
    HTTParty.get(bart_query) 
  end
    
end
