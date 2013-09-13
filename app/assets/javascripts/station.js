(function () {
	var BA = window.BA = {};

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
	}

	var closeAllTimes = BA.closeAllTimes = function () {
		$('.bubble').fadeOut(200); // versus hide() ???
	};

	var closeSpinner = BA.closeSpinner = function () {
		$('.spinner').hide();
	}
	
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
			});			
		});
	};
})();


$(document).ready(BA.initialize);
