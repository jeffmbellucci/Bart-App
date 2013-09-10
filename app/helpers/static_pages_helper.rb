module StaticPagesHelper
  API_KEY = ENV["BART_API_KEY"]
  
  def get_all_station_data
    bart_query = Addressable::URI.new(
      scheme: "http",
      host: "api.bart.gov",
      path: "api/etd.aspx",
      query_values: {
        cmd: "etd",
        orig: "all",
        key: API_KEY 
        })
  
   response = HTTParty.get(bart_query).to_json 
   JSON.parse(response)
  end
end
