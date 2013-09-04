$(document).ready(function() {
	$('#stations a').on('click', function() {
		//event.preventDefault();
		var $link = this;
		console.log($link.id);
		$($link).prepend($link.id +"  ");
		var station = getStationData($link.id, function(data){});
		
		
	});
});


//this way the callback has access to the link variable
// use anonymous function (data) {}

function getStationData(id, callback) {
	$.ajax({
		type: "GET",
		url: ("/stations/").concat(id).concat(".json"),
		success: callback
	});
}

// function prependHelper(data, $el) {
// 	$($el).prepend(parseStationData(data));
// }

function parseStationData(data) {
	var stationName = data['root']['station']['name'];
	var linesArray = data['root']['station']['etd'];
	for (var i = 0; i < linesArray.length; i++) {
		console.log(linesArray[i]);
	}
	console.log(JST["station_template"]);
}

this.template({data: data})