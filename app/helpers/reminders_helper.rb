module RemindersHelper
  
  def create_station_texts(station_abbr, user)
    data = get_station_data(station_abbr)
  
  	station_name = data['root']['station']['name'] 
  	current_time = data['root']['time'][0..-5].reverse.chomp("0").reverse

  	if data['root']['message']
      return ["Hi #{user.name}, #{station_name} has no trains at this time\n #{current_time}"]
    end
    
    header = "Hi #{user.name}, here are the Bart departure times for #{station_name} as of #{current_time}"
    northbound = ["NORTHBOUND\n"]
    southbound = ["SOUTHBOUND\n"]
      
    lines = data['root']['station']['etd']
    lines.each do |line|
      if line['estimate'][0]['direction'] == "North"
        northbound << "#{line['destination']}:\n"
        times = line['estimate']
        times.each { |time| northbound << (Time.now + time['minutes'].to_i.minutes).strftime("%l:%M") }
        northbound <<"\n"
      else
        southbound << "#{line['destination']}:\n"
        times = line['estimate']
        times.each { |time| southbound << (Time.now + time['minutes'].to_i.minutes).strftime("%l:%M") }
        southbound <<"\n"
      end
    end
    [header, northbound.join(""), southbound.join("")]
  end
  
  def send_reminder(station_abbr, user)
    texts = create_station_texts(station_abbr, user)
    texts.each do |message|
      text = Text.new(current_user.phone_number, message)
      text.send
    end
  end
  
end 	
 
 