(function () {
	var BA = window.BA = {};
	
	var initialize = BA.initialize = function() {
		$('#stationsMap a').on('click', function() {
			event.preventDefault();
		
			var $link = this;
			closeAllTimes();
			
			console.log($link.id);
		
			var spinnerView = JST["spinner_template"]();
			//add spinner
			$(spinnerView).hide().prependTo($($link).parent()).fadeIn(200);
			addCloseListener();
		 	
			getStationData($link.id, function(data){
				var stationTemplateFn = JST["station_template"];
				var timesView = stationTemplateFn({data: data});
			
				// hide spinner
				closeSpinner();
			
				$(timesView).prependTo($($link).parent());
				addCloseListener();
				addToggleListener();
			});			
		});
	};
	
	var getStationData = BA.getStationData = function (id, callback) {
		$.ajax({
			type: "GET",
			url: ("/stations/").concat(id).concat(".json"),
			success: callback
		});
	};

	var addCloseListener = BA.addCloseListener = function () {
		$(document).ready(function() {
			$('.closeLink').on('click', closeAllTimes);	
		});
	};
	
	var addToggleListener = BA.addToggleListener = function () {
		$(document).ready(function() {
			$('.toggleLink').on('click', toggleTimes);	
		});
	}

	var closeAllTimes = BA.closeAllTimes = function () {
		$('.bubble').fadeOut(200); // versus hide() ???
	};
	
	var toggleTimes = BA.toggleTimes = function () {
		$('.timesContainer').toggleClass("hidden");
		$('.minutesContainer').toggleClass("hidden");
	};

	var closeSpinner = BA.closeSpinner = function () {
		$('.spinner').hide();
	}
	
	var addMinutes = BA.addMinutes = function(date, minutes) {
		var newDate = new Date(date)
		newDate.setMinutes(date.getMinutes() + minutes)
		return newDate
	}
	
	var printTime = BA.printTime = function(date) {
		var output = new Array();
		if (date.getHours() > 12) {
		    output[0] = date.getHours() - 12;
		} else if (date.getHours() == 0 ) {
		    output[0] = "12";
		} else {
		    output[0] = date.getHours();
		}
		output[1] = ":"
		var minutes = date.getMinutes();
		//console.log(minutes)
		if (minutes < 10) {
		   output[2] = "0" + minutes;
		} else {
			output[2] = minutes;
		}
		return output.join("");
	}
	
})();

$(document).ready(BA.initialize);
