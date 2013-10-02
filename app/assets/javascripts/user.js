(function (root) {
	var BA = root.BA = (root.BA || {});
	
	var userHandler = BA.userHandler = function () {	
		addUserDeleteListener();
		signupCloser();
		aboutCloser();	
	};
	
	var deleteAccount = BA.deleteAccount = function (event) {
		event.preventDefault();
		var url = event.target.action;
		
		var choice = confirm("Just checking if you really meant to do that... \n \n Click OK to delete your account. \n");
		if (choice) {
			BA.sendDeleteRequest(url, function(data) {
				
				var alert = JST['alert_template']({data: {'alertType': 'alert alert-error', 
														  'message': 'Your Account has been deleted.'}});
				handleUserResponse(alert);
				setTimeout(function() { 
					location.reload();
				}, 2300);  		
			});
			
		} else {
			var alert = JST['alert_template']({data: {'alertType': 'alert alert-success', 
													  'message': 'You chose... Wisely.'}});
			handleUserResponse(alert);
		};		
	};

	var addUserDeleteListener = BA.addUserDeleteListener = function () {
		$('.account_delete_button').on('submit', deleteAccount);
	}
	
	var handleUserResponse = BA.handleUserResponse = function (alert) {
		$('.alert').remove();										  									  
	    $('#editModal').modal('hide');
		$('#wrap').append(alert);	
		setTimeout(function() { 
			$(".alert").fadeOut(300);
		}, 2000);  	
	};
	
	var signupCloser = BA.signupCloser = function () {
		$('#signup_contact_link').on('click', function () {
			$('#signinModal').modal('hide');
		});
	};
	
	var aboutCloser = BA.aboutCloser = function () {
		$('#about_contact_link').on('click', function () {
			$('#aboutModal').modal('hide');
		});
	};
		
})(this);

$(document).ready(BA.userHandler);
