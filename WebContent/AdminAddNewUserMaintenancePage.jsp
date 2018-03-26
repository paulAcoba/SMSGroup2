<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>

<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
<link rel="stylesheet" href="css/UserManagementStyle.css" type="text/css">
<script src="js/prototype.js"></script>
<script> var contextPath = "${pageContext.request.contextPath}";</script>
<title>Add New User</title>
</head>
<body>

	<div id="myModal" class="modal">
	  <div class="modal-content">
	    <span id="modalClose" class="close">&times;</span>
	    <p id="modalP"></p>
	  </div>
	</div>

	<div id="wrapper">
		<h3>User Maintenance</h3>
		<form>
			<div id="formDiv">
				<table>
					<tr><td><label>User ID</label></td><td><input type="text" id="userId" name="userId"></td></tr>
					<tr><td><label>Password</label></td><td><input type="password" id="password" name="password" readonly="readonly"></td></tr>
					<tr><td><label>First Name</label></td><td><input type="text" id="firstName" name="firstName"></td></tr>
					<tr><td><label>Last Name</label></td><td><input type="text" id="lastName" name="lastName"></td></tr>
					<tr><td><label>Middle Initial</label></td><td><input type="text" id="middleInitial" name="middleInitial"></td></tr>
					<tr><td><label>Email Address</label></td><td><input type="email" placeholder="default@example.com" id="email" name="email"></td></tr>
					<tr><td><label>Active Tag</label></td><td><input type="radio" id="activeTagYes" name="activeTag" checked="checked">Yes<input type="radio" id="activeTagNo" name="activeTag">No</td></tr>
					<tr><td><label>Access Level</label></td><td><select id="accessLevel" name="accessLevel" style="width:147px;">
																	<option value=""></option>
																	<option value="U">User</option>
																	<option value="A">Admin</option>
															  	</select></td></tr>
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
	
	if("${serviceResponse}" == "okay") {
		$("modalP").update("The user was successfully added.");
		$("myModal").writeAttribute("style", "display:block");
	}
	
	if("${serviceResponse}" == "duplicateEntry") {
		fillInFields();
		$("${errorField}").value = "";
		$("modalP").update("The user with " + "${errorField}" + " " + "${errorValue}" + " is already existing. Please enter new and unique " + "${errorField}" + ".");
		$("myModal").writeAttribute("style", "display:block");
	}
	
	if("${serviceResponse}" == "invalidCharacter") {
		fillInFields();
		$("${errorField}").value = "";
		$("modalP").update("You've entered an invalid value on " + "${errorField}" + ". Please check and retry");
		$("myModal").writeAttribute("style", "display:block");
	}
	
	if("${serviceResponse}" == "emptyField") {
		fillInFields();
		$("modalP").update("One or more fields are empty. Please complete all fields.");
		$("myModal").writeAttribute("style", "display:block");
	}
	
	function fillInFields() {
		$("userId").value = "${param.userId}";
		$("password").value = "${param.password}";
		$("firstName").value = "${param.firstName}";
		$("lastName").value = "${param.lastName}";
		$("middleInitial").value = "${param.middleInitial}";
		$("email").value = "${param.email}";
		$("accessLevel").value = "${param.accessLevel}";
		if("${param.activeTag}" == "Y"){
			$("activeTagYes").writeAttribute("checked", "checked");
		}
		if("${param.activeTag}" == "N"){
			$("activeTagNo").writeAttribute("checked", "checked");
		}
	}
	
	$("btnSave").observe("click", function() {
		var activeTag = "";
		if($("activeTagYes").checked){
			activeTag = "Y";
		} else if($("activeTagNo").checked){
			activeTag = "N";
		}
		
		new Ajax.Request(contextPath + "/adduser", {
			method: "POST",
			parameters: {
				userId: $F("userId"),
				password: $F("password"),
				firstName: $F("firstName"),
				lastName: $F("lastName"),
				middleInitial: $F("middleInitial"),
				email: $F("email"),
				activeTag: activeTag,
				accessLevel: $F("accessLevel")
			},
			onComplete: function(response){
				$("wrapper").update(response.responseText);
			}
		});
	});
	
	$("userId").observe("keyup", function(){
		$("password").value = $F("userId");
	});
	
	$("userId").observe("change", function(){
		$("password").value = $F("userId");
	});
	
	$("btnCancel").observe("click", function() {
		new Ajax.Request(contextPath + "/gate", {
			method: "POST",
			parameters: {
				gateKey: "adminUserListing"
			},
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