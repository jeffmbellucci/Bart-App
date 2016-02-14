(function (root) {
	var BA = root.BA = (root.BA || {});

	var initialize = BA.initialize = function() {

    $('#stationsMap a').on('click', function(event) {
			event.preventDefault();
			var $stationLink = $(event.currentTarget); // The link of the station clicked on by the user

			// Close all open time bubbles before opening a new one so that you can't open more than one at a time
			closeAllTimes();

			var spinnerView = JST["spinner_template"]();
			// Add spinner while waiting for Bart API response
			$(spinnerView).hide().prependTo($stationLink.parent()).fadeIn(200);
			addCloseListener();

			getStationData($stationLink.data('station-id'), function(data) {
				var stationTemplateFn = JST["station_template"];
				var timesView = stationTemplateFn({data: data});

				// Hide spinner after successful response from Bart API
				closeSpinner();

				$(timesView).prependTo($stationLink.parent());
				addCloseListener();
				addToggleListener();
			});
		});
	};

	var getStationData = BA.getStationData = function (id, callback) {
		$.ajax({
			type: "GET",
			url: "/stations/" + id,
			dataType: 'json',
			success: callback
		});
	};

	var addCloseListener = BA.addCloseListener = function () {
		$('.closeLink').on('click', closeAllTimes);
	};

	var addToggleListener = BA.addToggleListener = function () {
		$('.toggleLink').on('click', toggleTimes);
	}

	var closeAllTimes = BA.closeAllTimes = function () {
		$('.bubble').fadeOut(200, this.remove);
	};

	var toggleTimes = BA.toggleTimes = function () {
		$('.timesContainer').toggleClass("hidden");
		$('.minutesContainer').toggleClass("hidden");
	};

	var closeSpinner = BA.closeSpinner = function () {
		$('.spinner').remove();
	}

	var addMinutes = BA.addMinutes = function(date, minutes) {
		var newDate = new Date(date)
		newDate.setMinutes(date.getMinutes() + minutes);
		return newDate;
	};

	var printDate = BA.printDate = function(date) {
		return date.toString().substring(4, 10);
	};

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
		if (minutes < 10) {
		   output[2] = "0" + minutes;
		} else {
			output[2] = minutes;
		};
		return output.join("");
	};

	var printAmPm = BA.printAmPm = function (date) {
		if (date.getHours() < 12) {
			return "AM";
		} else {
			return "PM";
		};
	};

})(this);

$(document).ready(BA.initialize);
