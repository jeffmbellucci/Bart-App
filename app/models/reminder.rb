class Reminder < ActiveRecord::Base
  include StationsHelper
  
  attr_accessible :direction, :runtime, :station_abbr, :station_name, :user_id, :job_id, :completed
  validates :direction, :runtime, :station_abbr, :station_name, :user_id, presence: true
  
  belongs_to :user
  
  def delete_delayed_job
     Delayed::Job.find(self.job_id).destroy unless Delayed::Job.find_by_id(self.job_id).nil?
  end
  
  def create_station_texts
    data = get_station_data(station_abbr)
  
  	station_name = data['root']['station']['name'] 
  	current_time = data['root']['time'][0..-5].reverse.chomp("0").reverse
    meridian = current_time[-2..-1]
    current_time = current_time[0..-7] + meridian
    
  	if data['root']['message'] == "Bart is not providing updates at this time." 
      return ["Hi #{user.name}, Bart is not providing departure data for #{station_name} at this time.  Please try again later."]
    end
   
  	if data['root']['message']
      return ["Hi #{user.name}, #{station_name} has no trains at this time #{current_time}"]
    end
    
    header = "Hi #{user.name}, here are the #{direction.downcase} Bart departure times you requested for #{station_name} as of #{current_time}."
    northbound = []
    southbound = []
      
    lines = data['root']['station']['etd']
    lines.each do |line|
      
      # line['destination'] = "MILL" if line['destination'] == "Millbrae"
      # line['destination'] = "FREM" if line['destination'] == "Fremont"
      # line['destination'] = "DALY" if line['destination'] == "Daly City"
      # line['destination'] = "SFO" if line['destination'] == "SF Airport"
      # line['destination'] = "RICH" if line['destination'] == "Richmond"
      # line['destination'] = "PITT/BP" if line['destination'] == "Pittsburg/Bay Point"
      # line['destination'] = "DB/PLTN" if line['destination'] == "Dublin/Pleasanton"
      
      if line['estimate'][0]['direction'] == "North"
        northbound << "#{line['destination']}\n"
        times = line['estimate']
        times.each { |time| northbound << (Time.now - 7.hours - 1.hours + time['minutes'].to_i.minutes).strftime("%l:%M") + " " }
        # 1 extra hour subtracted for daylight savings
        northbound <<"\n"
      elsif line['estimate'][0]['direction'] == "South"
        southbound << "#{line['destination']}\n"
        times = line['estimate']
        times.each { |time| southbound << (Time.now - 7.hours - 1.hours + time['minutes'].to_i.minutes).strftime("%l:%M") + " " }
        # 1 extra hour subtracted for daylight savings
        southbound <<"\n"
      end
    end
    
    northbound << "#{station_name} has no northbound trains at this time." if northbound.empty?
    southbound << "#{station_name} has no southbound trains at this time." if southbound.empty?
    
    if direction == "Northbound"
      [header, northbound.join("")[0...160]]  #split into 2 texts if too long?
    elsif direction == "Southbound"
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
