module RemindersHelper
  
  def create_station_texts(abbr)
    data = get_station_data(abbr)
  
  	station_name = data['root']['station']['name'] 
  	current_time = data['root']['time'][0..-5]

  	if data['root']['message']
      return ["Hi #{current_user.name}, #{station_name} has no trains at this time\n #{current_time}"]
    end
    
    header = "Hi #{current_user.name}, here are the times for #{station_name} as of: #{current_time}"
    northbound = ["NORTHBOUND\n"]
    southbound = ["SOUTHBOUND\n"]
      
    lines = data['root']['station']['etd']
    lines.each do |line|
      if line['estimate'][0]['direction'] == "North"
        northbound << "#{line['destination']}:\n"
        times = line['estimate']
        times.each { |time| northbound << time['minutes'] }
        northbound <<"\n"
      else
        southbound << "#{line['destination']}:\n"
        times = line['estimate']
        times.each { |time| southbound << time['minutes'] }
        southbound <<"\n"
      end
    end
    [header, northbound.join(" "), southbound.join(" ")]
  end
end 	
   #  else
#       
#   
#       lines = data['root']['station']['etd']
#       <% for (var i = 0; i < lines.length; i++) { %>
#     
#         <span class='train <%=lines[i]['estimate'][0]['color'].toLowerCase() %>'>
#           <%= lines[i]['destination'] %>
#         </span>
#     
#         <% times = lines[i]['estimate'] %>
#         <% for (var j = 0; j < times.length; j++) { %>
#           <% if (times[j]['minutes'] != "Leaving" ) { %>
#             <% if (j === times.length - 1) { %>
#               <%= times[j]['minutes'] + " min" %>
#             <% } else {%>
#               <%= times[j]['minutes'] + "," %>
#             <% } %>
#           <% } else if (j === times.length - 1) { %>
#             <%= times[j]['minutes'] %>
#           <% } else { %>
#             <%= times[j]['minutes'] + "," %>
#           <% }; %>
#         <% }; %>
#     
#         <br>
#     
#       <% }; %>
#     <% }; %>
# 
#     <div class='currentTime'>
#       Times as of <%= data['root']['time'].substring(0, data['root']['time'].length - 3) %>  
#     </div>
# 
#   </div>
#   end
#   
# end
