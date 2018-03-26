<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<jsp:include page="peripherals/header.jsp"></jsp:include>
<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
<link rel="stylesheet" href="css/UserManagementStyle.css" type="text/css">
<script src="js/prototype.js"></script>
<script> var contextPath = "${pageContext.request.contextPath}";</script>
<title>Change Password</title>
</head>
<body>
	<div id="wrapper">
		<jsp:include page="peripherals/nav.jsp"></jsp:include>
		<div id="myModal" class="modal">
		  <div class="modal-content">
		    <span id="modalClose" class="close">&times;</span>
		    <p id="modalP"></p>
		  </div>
		</div>
		<h3>Change Password</h3>
		<form>
			<div id="formDiv">
				<table>
					<tr><td><label>Current Password</label></td><td><input type="password" id="currentPassword" name="currentPassword"></td></tr>
					<tr><td><label>New Password</label></td><td><input type="password" id="newPassword" name="newPassword"></td></tr>
					<tr><td><label>Retype Password</label></td><td><input type="password" id="retypePassword" name="retypePassword"></td></tr>
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

	if("${serviceResponse}" == "emptyField") {
		$("modalP").update("One or more fields are empty. Please complete all fields.");
		$("myModal").writeAttribute("style", "display:block");
	}

	if("${serviceResponse}" == "wrongPassword") {
		$("modalP").update("You've entered a wrong password.");
		$("myModal").writeAttribute("style", "display:block");
	}
	
	if("${serviceResponse}" == "belowMinimumCharacters") {
		$("modalP").update("The password you've entered is below 8 characters. Please enter valid password.");
		$("myModal").writeAttribute("style", "display:block");
	}
	
	if("${serviceResponse}" == "aboveMaximumCharacters") {
		$("modalP").update("The password you've entered is above 20 characters. Please enter valid password.");
		$("myModal").writeAttribute("style", "display:block");
	}
	
	$("btnSave").observe("click", function(){
		if($F("newPassword") == $F("retypePassword")) {
			new Ajax.Request(contextPath + "/updatepassword", {
				method: "POST",
				parameters: {
					userType: "${param.userType}",
					currentPassword: $F("currentPassword"),
					newPassword: $F("newPassword")
				},
				onComplete: function(response){
					$("wrapper").update(response.responseText);
				}
			});
			
		} else {
			alert("Retype Password should match the value of New Password.");
			
		}
	});
	
	$("btnCancel").observe("click", function() {
		
		if("${param.userType}" == "admin") {
			new Ajax.Request(contextPath + "/gate", {
				method: "POST",
				parameters: {
					gateKey: "adminUserListing"
				},
				onComplete: function(response){
					$("wrapper").update(response.responseText);
				}
			});
		}
		
		if("${param.userType}" == "user") {
			new Ajax.Request(contextPath + "/gate", {
				method: "POST",
				parameters: {
					gateKey: "userUpdateProfile"
				},
				onComplete: function(response){
					$("wrapper").update(response.responseText);
				}
			});
		}
		
	});
	
	$("modalClose").observe("click", function(){
		myModal.writeAttribute("style", "display:none");
	});
</script>
</html>