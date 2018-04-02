<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<jsp:include page="peripherals/header.jsp"></jsp:include>
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
	
	<div id="wrapper2">
	<jsp:include page="peripherals/nav.jsp"></jsp:include>
		<div class="panel panel-info" id="userDataForm">
			<div class="panel-heading">User Profile</div>
			<div class="panel-body">
		<form method="POST">
			<div id="formDiv">
				<table>
					<tr><td><label>User ID</label></td><td><input type="text" id="userId" name="userId" disabled="disabled" class="form-control"></td></tr>
					<tr><td><label>Password</label></td><td><input type="password" id="password" name="password" disabled="disabled" class="form-control"></td><td><input type="button" id="btnChangePassword" value="Change Password" class="btn btn-success"></td></tr>
					<tr><td><label>First Name</label></td><td><input type="text" id="firstName" name="firstName" class="form-control"></td></tr>
					<tr><td><label>Last Name</label></td><td><input type="text" id="lastName" name="lastName" class="form-control"></td></tr>
					<tr><td><label>Middle Initial</label></td><td><input type="text" id="middleInitial" name="middleInitial" class="form-control"></td></tr>
					<tr><td><label>Email Address</label></td><td><input type="email" placeholder="default@example.com" id="email" name="email" class="form-control"></td></tr>
				</table>
			</div>
			<div id="buttonsDiv">
				<button type="button" id="btnSave" class="btn btn-primary"><span class="glyphicon glyphicon-ok"></span>Save</button><br>
				<button type="button" id="btnCancel" class="btn btn-danger">Cancel</button>
			</div>
		</form>
		</div>
	</div>
	</div>
</body>
<script>

	$("userId").value = "${userId}";
	$("firstName").value = "${firstName}";
	$("lastName").value = "${lastName}";
	$("middleInitial").value = "${middleInitial}";
	$("email").value = "${email}";
	$("password").value = "${password}";

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
	
	if("${serviceResponse}" == "SQLException") {
		$("modalP").update("Cannot connect properly to databse. Please contact administrator.");
		$("myModal").writeAttribute("style", "display:block");
	}
	
	if("${serviceResponse}" == "aboveMaximumCharacters") {
		$("modalP").update("Middle Name should not exceed 3 characters. Please check and retry.");
		$("myModal").writeAttribute("style", "display:block");
	}
	
	$("btnSave").observe("click", function() {
		new Ajax.Request(contextPath + "/updateprofile", {
			method: "POST",
			parameters: {
				userType: "user",
				userId: $F("userId"),
				password: $F("password"),
				firstName: $F("firstName"),
				lastName: $F("lastName"),
				email: $F("email"),
				middleInitial: $F("middleInitial")
			},
			onComplete: function(response) {
				$("wrapper2").update(response.responseText);
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
				$("wrapper2").update(response.responseText);
			}
		});
	});
	
	$("btnCancel").observe("click", function() {
		new Ajax.Request(contextPath + "/gate", {
			method : "GET",
			onFailure : function(response){
				$("incorrect/blocked").update(response.responseText);
			},
			onSuccess : function(response) {

				$("wrapper2").update(response.responseText);

				
			}
		});
	});
	
	$("modalClose").observe("click", function(){
		$("myModal").writeAttribute("style", "display:none");
	});
</script>
</html>