(function (root) {
	var BA = root.BA = (root.BA || {});
	
	var reminderHandler = BA.reminderHandler = function () {
		accordionToggleHider();
		addDeleteListenerOld();
		addRefreshListener();
		$('#reminder_form').on('submit', function(event) {
			event.preventDefault();
			var formData = $(this).serialize();
			
			var reminder_notice = JST["new_reminder_notice"]();
			$(reminder_notice).prependTo($(".reminder_link"));
			setTimeout(function() { 
				$(".reminder_notice").fadeOut(300);
			}, 300); // remove?
			
			sendReminderData(formData, function(data) {
				console.log(data);
				$(".empty_reminders").remove(); //versus hide?
				var reminderTemplateFn = JST["reminder_template"];
				var reminderView = reminderTemplateFn({data: data});
				$(reminderView).prependTo($("#reminder_list"));
				addDeleteListenerNew(data.id);
			});	
		});
	};
	
	var deleteReminder = BA.deleteReminder = function (event) {
		event.preventDefault();
		var url = event.target.action;
		
		var reminder_notice = JST["deleted_reminder_notice"]();
		$(reminder_notice).prependTo($(".reminder_link"));
		setTimeout(function() { 
			$(".reminder_notice").fadeOut(300); // remove?
		}, 300);
		
		sendDeleteRequest(url, function(data) {
			console.log(data);	
			var reminder_id = "#reminder_" + data[1]; 
			$(reminder_id).remove(); //hide?
			if (data[0] == "0") {
				var emptyReminder = JST["empty_reminder"]();
				$(emptyReminder).prependTo($("#reminder_list"));
			};
		});
	};
	
	var refreshReminders = BA.refreshReminders = function (event) {
		event.preventDefault();
		
		var reminder_notice = JST["refreshed_reminder_notice"]();
		$(reminder_notice).prependTo($(".reminder_link"));
		setTimeout(function() { 
			$(".reminder_notice").fadeOut(300);
		}, 300); // remove?
		
		getReminders(function (data) {
			$(".reminder_container").remove(); // hide?
			console.log(data);
			for (var i = 0; i < data.length; i++) {
				var reminderTemplateFn = JST["reminder_template"];
				var reminderView = reminderTemplateFn({data: data[i]});
				$(reminderView).prependTo($("#reminder_list"));
				addDeleteListenerNew(data[i].id);
			};
		});
	};
		
	var sendReminderData = BA.sendReminderData = function (formData, callback) {
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
	
	var sendDeleteRequest = BA.sendDeleteRequest = function (url, callback) {
		$.ajax({
			type: "DELETE",
			url: url,
			success: callback
		});
	};
	
	var getReminders = BA.getReminders = function (callback) {
		$.ajax({
			type: "GET",
			url: "/reminders",
			success: callback
		})
	};
	
	var addRefreshListener = BA.addRefreshListener = function () {
		$("#refresh_form").on("submit", refreshReminders);
	}
	
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
