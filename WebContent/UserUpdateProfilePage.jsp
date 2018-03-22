<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
<title>Update Profile</title>
</head>
<body>
	<div id="wrapper">
		<div id="formDiv">
			<table>
				<tr><td><label>User ID</label></td><td><input type="text" id="userId" name="userId" disabled="disabled"></td></tr>
				<tr><td><label>Password</label></td><td><input type="password" id="password" name="password" disabled="disabled"></td><td><input type="button" id="btnChangePassword" value="changePassword"></td></tr>
				<tr><td><label>First Name</label></td><td><input type="text" id="firstName" name="firstName"></td></tr>
				<tr><td><label>Last Name</label></td><td><input type="text" id="lastName" name="lastName"></td></tr>
				<tr><td><label>Middle Initial</label></td><td><input type="text" id="middleInitial" name="middleInitial"></td></tr>
				<tr><td><label>Email Address</label></td><td><input type="text" id="email" name="email"></td></tr>
			</table>
		</div>
		<div id="buttonsDiv">
			<input type="button" id="btnSave" value="Save"><br>
			<input type="button" id="btnCancel" value="Cancel">
		</div>
	</div>
</body>
</html>