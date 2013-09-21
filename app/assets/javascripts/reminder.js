(function (root) {
	var BA = root.BA = (root.BA || {});
	
	var reminderSubmitter = BA.reminderSubmitter = function() {
		$('#reminder_form').on('submit', function() {
			event.preventDefault();
			var formData = $(this).serialize();
			sendReminderData(formData, function(data) {
				console.log(data);
				
				var reminderTemplateFn = JST["reminder_template"];
				var reminderView = reminderTemplateFn({data: data});
				
				$(".empty_reminders").hide();
				$(reminderView).prependTo($("#reminder_list"));
				alert("Reminder created.")
			});	
		});
	};
	
	//need to add submit listener to all new reminders
	
	var reminderDeleter = BA.reminderDeleter = function() {
		// move this to add delete listener
		$('.reminder_delete_button').on('submit', function() { 
			alert("button clicked")
			event.preventDefault();
			var url = event.target.action;
			
			console.log(url)
			
			sendDeleteRequest(url, function(data) {
				var reminder_id = "#reminder_" + url.substring(32,34)
				console.log(reminder_id);
				console.log(data);
				$(reminder_id).hide();
				if (data == "0") {
					var emptyView = JST["empty_reminder"]();
					$(emptyView).prependTo($("#reminder_list"));
				};
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
	
	var sendDeleteRequest = BA.sendDeleteData = function(url, callback) {
		$.ajax({
			type: "DELETE",
			url: url,
			success: callback
		})
	}
	
	var addDeleteListener = BA.addDeleteListener = function() {
		$(document).ready(function () {
			$('.reminder_delete_button').on('submit', deleteReminder);
		});
	};
	
	// write deleteReminder();
	
})(this);

$(document).ready(BA.reminderSubmitter);
$(document).ready(BA.reminderDeleter);