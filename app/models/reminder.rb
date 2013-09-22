class Reminder < ActiveRecord::Base
  include StationsHelper
  
  attr_accessible :direction, :runtime, :station_abbr, :station_name, :user_id, :job_id, :completed
  validates :direction, :runtime, :station_abbr, :station_name, :user_id, presence: true
  
  belongs_to :user
  
  def create_station_texts
    data = get_station_data(station_abbr)
  
  	station_name = data['root']['station']['name'] 
  	current_time = data['root']['time'][0..-5].reverse.chomp("0").reverse
    # current_time = current_time[0..-7]
   
  	if data['root']['message']
      return ["Hi #{user.name}, #{station_name} has no trains at this time #{current_time}"]
    end
    
    header = "Hi #{user.name}, here are the #{direction} Bart departure times you requested for #{station_name} as of #{current_time}."
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
    if direction == "northbound"
      [header, northbound.join("")[0...160]]  #split into 2 texts if too long
    else
      [header, southbound.join("")[0...160]]
    end
  end
  
  def perform        
    texts = create_station_texts
    texts.each do |message|
      text = Text.new(user.phone_number, message)
      text.send
    end
    self.completed = true
    self.save
  end
    
end
