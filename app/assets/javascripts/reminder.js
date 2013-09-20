(function (root) {
	var BA = root.BA = (root.BA || {});
	
	var reminderSubmitter = BA.reminderSubmitter = function() {
		$('#reminder_form').on('submit', function() {
			event.preventDefault();
			console.log(event.target.action)
			var formData = $(this).serialize();
			
			sendReminderData(formData, function(data) {
				console.log(data);
				alert("Reminder created.")
			});	
		});
	};
		
	var sendReminderData = BA.sendReminderData = function(formData, callback) {
		//console.log(formData)
		$.ajax({
			type: "POST",
			url: "/reminders",
			data: formData,
			success: callback,
			error: function (data) {
				alert(data.responseText);
			}
		});
	};
	
	
})(this);

$(document).ready(BA.reminderSubmitter);
