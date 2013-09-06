$(document).ready(function() {
	$('#stationsMap a').on('click', function() {
		event.preventDefault();
		
		var $link = this;
		closeAllTimes();
		
		console.log($link.id);
		
		//show bubble template
		//add spinner
		
		getStationData($link.id, function(data){
			
			var stationTemplateFn = JST["station_template"];
			var contentToAdd = stationTemplateFn({data: data});
			// hide spinner
			$(contentToAdd).hide().prependTo($($link).parent()).fadeIn(200);
			
			addCloseListener();
		});	
			
	});
});

// append template to li
// div onclick='functionName()';

function getStationData(id, callback) {
	$.ajax({
		type: "GET",
		url: ("/stations/").concat(id).concat(".json"),
		success: callback
	});
};

function addCloseListener() {
	$(document).ready(function() {
		$('.closeLink').on('click', closeAllTimes);	
	});
}

function closeAllTimes() {
	$('.bubble').fadeOut(200); // versus hide() ???
};

function getNumLines(data) {
	var num = data['root']['station']['etd'].length;
	return num;
};
	

