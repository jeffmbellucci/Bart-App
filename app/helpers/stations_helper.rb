module StationsHelper
  BART_API_KEY = ENV["BART_API_KEY"]
  
  def get_station_data(abbr)
    bart_query = Addressable::URI.new(
      scheme: "http",
      host: "api.bart.gov",
      path: "api/etd.aspx",
      query_values: {
        cmd: "etd",
        orig: abbr,
        key: BART_API_KEY 
      })
      
    response = HTTParty.get(bart_query).to_json
    json_response = JSON.parse(response)
    
    if json_response['root']['message']
      json_response['root']['message'] = "No trains at this time." 
      return json_response
   end
   
   if json_response['root']['station']['message'] == "Updates are temporarily unavailable."
     json_response['root']['message'] = "Bart is not providing updates at this time." 
     return json_response
  end
  
    unless json_response['root']['station']['etd'].is_a?(Array)
      json_response['root']['station']['etd'] = [json_response['root']['station']['etd']]
    end
    
    lines = json_response['root']['station']['etd']
    lines.each do |line|
      line['estimate'] = [line['estimate']] unless line['estimate'].is_a?(Array)
    end
    json_response   
  end
end
