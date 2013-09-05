$(document).ready(function() {
	$('#stations a').on('click', function() {
		event.preventDefault();
		closeAllTimes();
		
		var $link = this;
		
		console.log($link.id);
		
		getStationData($link.id, function(data){
			trains = getNumTrains(data);
			bubbleHeight = (trains * 20 + 40) + "px";
			console.log(bubbleHeight);
			var stationTemplateFn = JST["station_template"];
			var contentToAdd = stationTemplateFn({data: data});
			
			$(contentToAdd).hide().prependTo($($link).parent()).fadeIn('slow');
			//$(".bubble").css("height", bubbleHeight);
			closeListener();
		});		
	});
});

// append template to li

// div onclick='functionName();
//this way the callback has access to the link variable
// use anonymous function (data) {}

function getStationData(id, callback) {
	$.ajax({
		type: "GET",
		url: ("/stations/").concat(id).concat(".json"),
		success: callback
	});
};

function closeListener() {
	$(document).ready(function() {
		$('.closeLink').on('click', closeAllTimes)
	});
}

function closeAllTimes() {
	$('.bubble').hide();
};

function getNumTrains(data) {
	var num = data['root']['station']['etd'].length;
	return num;
}
	

