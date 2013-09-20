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
	
	var reminderDeleter = BA.reminderDeleter = function(id, callback) {
		$('.reminder_delete_button').on('submit', function() {
			event.preventDefault();
			var url = event.target.action;
			
			console.log(url)
			
			sendDeleteData(url, function(data) {
				var reminder_id ="#reminder_" + url.substring(32,34)
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
	
	var sendDeleteData = BA.sendDeleteData = function(url, callback) {
		$.ajax({
			type: "DELETE",
			url: url,
			success: callback
		})
	}
	
	
	
})(this);

$(document).ready(BA.reminderSubmitter);
$(document).ready(BA.reminderDeleter);