$(document).ready(function() {
	$('#stations a').on('click', function() {
		event.preventDefault();
		var $link = this;
		console.log($link.id);
		
		var station = getStationData($link.id, parseStationData);
		$($link).prepend($link.id);
		
		console.log(station);
	});
});




function getStationData(id, callback) {
	$.ajax({
		type: "GET",
		url: ("/stations/").concat(id).concat(".json"),
		success: callback
	});
}


function parseStationData(data) {
	var stationName = data['root']['station']['name'];
	var linesArray = data['root']['station']['etd'];
	for (var i = 0; i < linesArray.length; i++) {
		console.log(linesArray[i]);
	}
	return stationName;
}