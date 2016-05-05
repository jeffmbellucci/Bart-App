(function (root) {
	var BA = root.BA = (root.BA || {});

	var closestStationsHandler = BA.closestStationsHandler = function () {
		addClosestStationsListener();
	};

	var addClosestStationsListener = BA.addClosestStationsListener = function () {
		$('#closest_station').on("click", function (event) {
			event.preventDefault();
			$('.alert').remove();
			var alert = JST['alert_template']({data: {'alertType': 'alert alert-success', 'message': 'Calculating your closest station...'}});
			$('#wrap').append(alert);
			getUserPosition();
		});
	};

	var getUserPosition = BA.getUserPosition = function () {
		if (navigator.geolocation) {
			navigator.geolocation.getCurrentPosition(sendPositionData);
		} else {
			alert("Geolocation is not supported by this browser.");
		};
	};

	//add contains method to string
	String.prototype.contains = function(it) { return this.indexOf(it) != -1; };

	var sendPositionData = BA.sendPositionData = function (position) {
		$.ajax({
			type: "POST",
			url: "/closest_stations",
			data: position.coords,
			success: function (data) {
				$('.alert').remove();
				if (data.length === 0) {
					var alert = JST['alert_template']({data: {'alertType': 'alert alert-error', 'message': 'There are no BART stations in your area.'}});
					$('#wrap').append(alert);
					return;
				}
				var stationName = data[0]['name'];
				//console.log(data); // Will give response array from Google places API
				if (stationName.contains("BART") || stationName.contains("Bart") || stationName.contains("Station")) {
					var alert = JST['alert_template']({data: {'alertType': 'alert alert-success', 'message': 'Your closest station: ' + stationName}});
					$('#wrap').append(alert);
				} else {
					var alert = JST['alert_template']({data: {'alertType': 'alert alert-success', 'message': 'Best guess: ' + stationName}});
					$('#wrap').append(alert);
				}
			},
      error: function (data) {
				var alert = JST['alert_template']({data: {'alertType': 'alert alert-error', 'message': 'Geolocation has been deprecated without SSL.'}});
				$('#wrap').append(alert);
      }
		});
	};

})(this);

$(document).ready(BA.closestStationsHandler);
