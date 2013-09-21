(function (root) {
	var BA = root.BA = (root.BA || {});
	
	var reminderSubmitter = BA.reminderHandler = function () {
		addDeleteListenerOld();
		$('#reminder_form').on('submit', function() {
			event.preventDefault();
			var formData = $(this).serialize();
			
			var reminder_notice = JST["new_reminder_notice"]();
			$(reminder_notice).prependTo($(".reminder_link"));
			$(".reminder_notice").fadeOut(500);
			
			sendReminderData(formData, function(data) {
				console.log(data);
				$(".empty_reminders").hide();
				var reminderTemplateFn = JST["reminder_template"];
				var reminderView = reminderTemplateFn({data: data});
				$(reminderView).prependTo($("#reminder_list"));
				addDeleteListenerNew();
			});	
		});
	};
		
	var sendReminderData = BA.sendReminderData = function (data, callback) {
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
	
	var sendDeleteRequest = BA.sendDeleteData = function (url, callback) {
		$.ajax({
			type: "DELETE",
			url: url,
			success: callback
		})
	}
	
	var addDeleteListenerNew = BA.addDeleteListenerNew = function () {
		$('.reminder_delete_button_new').on('submit', deleteReminder);
	};
	
	var addDeleteListenerOld = BA.addDeleteListenerOld = function () {
		$('.reminder_delete_button_old').on('submit', deleteReminder);
	}
	
	var deleteReminder = BA.deleteReminder = function () {
		event.preventDefault();
		var url = event.target.action;
		
		var reminder_notice = JST["deleted_reminder_notice"]();
		$(reminder_notice).prependTo($(".reminder_link"));
		$(".reminder_notice").fadeOut(500);
		console.log(url)
		
		sendDeleteRequest(url, function(data) {
			var reminder_id = "#reminder_" + url.substring(32, url.length) 
			//this will have to change in production
			console.log(reminder_id);
			$(reminder_id).hide();
			if (data == "0") {
				var emptyView = JST["empty_reminder"]();
				$(emptyView).prependTo($("#reminder_list"));
			};
		});
	}

})(this);

$(document).ready(BA.reminderHandler);
