(function (root) {
	var BA = root.BA = (root.BA || {});
	
	var reminderSubmitter = BA.reminderSubmitter = function() {
		$('#reminder_form').on('submit', function() {
			event.preventDefault();
			var formData = $(this).serialize();
			sendReminderData(formData, function(data) {
				console.log(data);
				alert("Reminder created.")
			});	
		});
	};
	
	var reminderDeleter = BA.reminderDeleter = function(id, callback) {
		console.log("inside deleter")
		$('.reminder_delete').on('submit', function() {
			event.preventDefault();
			var formData = $(this).serialize();
			console.log(formData);
			sendDeleteData(event.target.action, formData, function(data) {
				console.log(data)
			});
			
		});
	}
		
	var sendReminderData = BA.sendReminderData = function(data, callback) {
		$.ajax({
			type: "POST",
			url: "/reminders",
			data: data,
			success: callback,
			error: function (data) {
				alert(data.responseText);
			}
		});
	};
	
	var sendDeleteData = BA.sendDeleteData = function(url, data, callback) {
		$.ajax({
			type: "DELETE",
			url: url,
			success: callback
		})
	}
	
	
	
})(this);

$(document).ready(BA.reminderSubmitter);
$(document).ready(BA.reminderDeleter);