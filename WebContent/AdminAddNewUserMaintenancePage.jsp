<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>

<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
<script src="js/prototype.js"></script>
<script> var contextPath = "${pageContext.request.contextPath}";</script>
<title>Add New User</title>
</head>
<body>
	<div id="wrapper">
		<h3>User Maintenance</h3>
		<div id="formDiv">
			<table>
				<tr><td><label>User ID</label></td><td><input type="text" id="userId" name="userId"></td></tr>
				<tr><td><label>Password</label></td><td><input type="password" id="password" name="password" disabled="disabled"></td></tr>
				<tr><td><label>First Name</label></td><td><input type="text" id="firstName" name="firstName"></td></tr>
				<tr><td><label>Last Name</label></td><td><input type="text" id="lastName" name="lastName"></td></tr>
				<tr><td><label>Middle Initial</label></td><td><input type="text" id="middleInitial" name="middleInitial"></td></tr>
				<tr><td><label>Email Address</label></td><td><input type="text" id="email" name="email"></td></tr>
				<tr><td><label>Active Tag</label></td><td><input type="radio" id="activeTagYes" name="activeTag" checked="checked">Yes<input type="radio" id="activeTagNo" name="activeTag">No</td></tr>
				<tr><td><label>Access Level</label></td><td><select id="accessLevel" name="accessLevel" >
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
	</div>
</body>
<script>
	
	if("${serviceResponse}" != "okay" && "${serviceResponse}" != "") {
		alert("${serviceResponse}");
	}
	
	function addNewUser() {
		var activeTag = "";
		if($("activeTagYes").checked){
			activeTag = "Y";
		} else if($("activeTagNo").checked){
			activeTag = "N";
		}
		
		new Ajax.Request(contextPath + "/add", {
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
	}
	
	$("userId").observe("keyup", function(){
		$("password").value = $F("userId");
	});
	
	$("btnSave").observe("click", function(){
		addNewUser();
	});
</script>
</html>