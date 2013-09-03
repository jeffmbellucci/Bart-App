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
        })
      
    response = HTTParty.get(bart_query).to_json
    json_response = JSON.parse(response)
    
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
