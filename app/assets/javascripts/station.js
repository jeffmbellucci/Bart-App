$(document).ready(function() {
	$('#stationsMap a').on('click', function() {
		event.preventDefault();
		
		var $link = this;
		closeAllTimes();
		
		console.log($link.id);
		
		var spinnerView = JST["spinner_template"]();
		$(spinnerView).hide().prependTo($($link).parent()).fadeIn(200);
		 addCloseListener();
		 
		getStationData($link.id, function(data){
			
			var stationTemplateFn = JST["station_template"];
			var timesView = stationTemplateFn({data: data});
			closeSpinner();
			
			$(timesView).prependTo($($link).parent());
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

function closeSpinner() {
	$('.spinner').hide();
}

function getNumLines(data) {
	var num = data['root']['station']['etd'].length;
	return num;
};
	

