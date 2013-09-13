class Reminder < Struct.new(:options)

  def create_station_texts
    data = StationsHelper::get_station_data(options[:abbr])
  
  	station_name = data['root']['station']['name'] 
  	current_time = data['root']['time'][0..-5].reverse.chomp("0").reverse
   
  	if data['root']['message']
      return ["Hi #{options[:user].name}, #{station_name} has no trains at this time\n #{current_time}"]
    end
    
    header = "Hi #{options[:user].name}, here are the Bart departure times you requested for #{station_name} as of #{current_time}"
    northbound = ["NORTHBOUND\n"]
    southbound = ["SOUTHBOUND\n"]
      
    lines = data['root']['station']['etd']
    lines.each do |line|
      if line['estimate'][0]['direction'] == "North"
        northbound << "#{line['destination']}\n"
        times = line['estimate']
        times.each { |time| northbound << (Time.now + time['minutes'].to_i.minutes).strftime("%l:%M") + " " }
        northbound <<"\n"
      else
        southbound << "#{line['destination']}\n"
        times = line['estimate']
        times.each { |time| southbound << (Time.now + time['minutes'].to_i.minutes).strftime("%l:%M") + " " }
        southbound <<"\n"
      end
    end
    if options[:direction] == "north"
      [header, northbound.join("")[0...160]]
    else
      [header, southbound.join("")[0...160]]
    end
  end
  
  def perform           
    texts = create_station_texts
    texts.each do |message|
      text = Text.new(options[:user].phone_number, message)
      text.send
    end
  end
  
end