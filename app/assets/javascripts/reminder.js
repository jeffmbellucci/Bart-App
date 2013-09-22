(function (root) {
	var BA = root.BA = (root.BA || {});
	
	var reminderHandler = BA.reminderHandler = function () {
		accordionToggleHider();
		addDeleteListenerOld();
		$('#reminder_form').on('submit', function() {
			event.preventDefault();
			var formData = $(this).serialize();
			var reminder_notice = JST["new_reminder_notice"]();
			
			sendReminderData(formData, function(data) {
				console.log(data);
				$(reminder_notice).prependTo($(".reminder_link"));
				$(".reminder_notice").fadeOut(500);
				$(".empty_reminders").hide();
				var reminderTemplateFn = JST["reminder_template"];
				var reminderView = reminderTemplateFn({data: data});
				$(reminderView).prependTo($("#reminder_list"));
				addDeleteListenerNew(data.id);
			});	
		});
	};
	
	var deleteReminder = BA.deleteReminder = function () {
		event.preventDefault();
		var url = event.target.action;
		
		var reminder_notice = JST["deleted_reminder_notice"]();
		$(reminder_notice).prependTo($(".reminder_link"));
		$(".reminder_notice").fadeOut(500);
		//console.log(url)
		
		sendDeleteRequest(url, function(data) {
			console.log(data);
			
			var reminder_id = "#reminder_" + data[1] 
			console.log(reminder_id);
			$(reminder_id).hide();
			if (data[0] == "0") {
				var emptyReminder = JST["empty_reminder"]();
				$(emptyReminder).prependTo($("#reminder_list"));
			};
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
		});
	};
	
	var addDeleteListenerNew = BA.addDeleteListenerNew = function (id) {
		$('.reminder_delete_button_' + id).on('submit', deleteReminder);
	};
	
	var addDeleteListenerOld = BA.addDeleteListenerOld = function () {
		$('.reminder_delete_button').on('submit', deleteReminder);
	}
	
	var accordionToggleHider = BA.reminderLinkHider = function () {
		$(".accordion-toggle").on("click", hideAccordionToggle);
	};
	
	var hideAccordionToggle = BA.hideAccordionToggle = function () {
		$(".reminder_button_container").toggleClass("hidden");
		$(".link-toggle").toggleClass("hidden");
	}
	
})(this);

$(document).ready(BA.reminderHandler);
