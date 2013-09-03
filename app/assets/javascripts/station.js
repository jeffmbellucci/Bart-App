$(document).ready(function() {
	$('#stations').on('click', function() {
		alert("click");
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
	console.log(stationName);
	var linesArray = data['root']['station']['etd'];
	for (var i = 0; i < linesArray.length, i++) {
		console.log(linesArray[i])
	}
	console.log(linesArray)
}