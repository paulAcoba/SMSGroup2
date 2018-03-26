<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
<script src="js/prototype.js"></script>
<link rel="stylesheet" href="css/UserManagementStyle.css" type="text/css">
<script> var contextPath = "${pageContext.request.contextPath}";</script>
<title>Update Profile</title>
</head>
<body>

	<div id="myModal" class="modal">
	  <div class="modal-content">
	    <span id="modalClose" class="close">&times;</span>
	    <p id="modalP"></p>
	  </div>
	</div>
	
	<div id="wrapper">
		<form method="POST">
			<div id="formDiv">
				<table>
					<tr><td><label>User ID</label></td><td><input type="text" id="userId" name="userId" disabled="disabled"></td></tr>
					<tr><td><label>Password</label></td><td><input type="password" id="password" name="password" disabled="disabled"></td><td><input type="button" id="btnChangePassword" value="Change Password"></td></tr>
					<tr><td><label>First Name</label></td><td><input type="text" id="firstName" name="firstName"></td></tr>
					<tr><td><label>Last Name</label></td><td><input type="text" id="lastName" name="lastName"></td></tr>
					<tr><td><label>Middle Initial</label></td><td><input type="text" id="middleInitial" name="middleInitial"></td></tr>
					<tr><td><label>Email Address</label></td><td><input type="email" placeholder="default@example.com" id="email" name="email"></td></tr>
				</table>
			</div>
			<div id="buttonsDiv">
				<input type="button" id="btnSave" value="Save"><br>
				<input type="button" id="btnCancel" value="Cancel">
			</div>
		</form>
	</div>
</body>
<script>

	$("userId").value = $(row.id).down(0).innerHTML;
	$("firstName").value = $(row.id).down(1).innerHTML;
	$("lastName").value = $(row.id).down(2).innerHTML;
	$("middleInitial").value = $(row.id).down(3).innerHTML;
	$("email").value = $(row.id).down(4).innerHTML;
	$("password").value = $(row.id).down(11).innerHTML;

	if("${serviceResponse}" == "okay") {
		$("modalP").update("The changes were successfully saved.");
		$("myModal").writeAttribute("style", "display:block");
	}
	
	if("${serviceResponse}" == "emptyField") {
		$("modalP").update("One or more fields are empty. Please complete all fields.");
		$("myModal").writeAttribute("style", "display:block");
	}
	
	if("${serviceResponse}" == "invalidCharacter") {
		$("modalP").update("You've entered an invalid value on " + "${errorField}" + ". Please check and retry");
		$("myModal").writeAttribute("style", "display:block");
	}
	
	$("btnSave").observe("click", function() {
		new Ajax.Request(contextPath + "/updateprofile", {
			method: "POST",
			parameters: {
				userType: "user",
				firstName: $F("firstName"),
				lastName: $F("lastName"),
				email: $F("email"),
				middleInitial: $F("middleInitial")
			},
			onComplete: function(response) {
				$("wrapper").update(response.responseText);
			}
		});
	});
	
	
	$("btnChangePassword").observe("click", function(){
		new Ajax.Request(contextPath + "/gate", {
			method: "POST",
			parameters: {
				userType: "user",
				gateKey: "updatePassword"
			},
			onComplete: function(response){
				$("wrapper").update(response.responseText);
			}
		});
	});
	
	$("btnCancel").observe("click", function() {
		new Ajax.Request(contextPath, {
			method: "POST",
			onComplete: function(response){
				$("wrapper").update(response.responseText);
			}
		});
	});
	
	$("modalClose").observe("click", function(){
		myModal.writeAttribute("style", "display:none");
	});
</script>
</html>