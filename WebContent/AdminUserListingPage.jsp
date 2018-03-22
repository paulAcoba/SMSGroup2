<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
<script src="js/prototype.js"></script>
<title>User Listing</title>
</head>
<body>
	<div id="wrapper">
		<h3>User Maintenance</h3>
		<div id="formDiv">
			<table>
				<tr><td><label>User ID</label></td><td><input type="text" id="userId" name="userId" disabled="disabled"></td></tr>
				<tr><td><label>Password</label></td><td><input type="password" id="password" name="password" disabled="disabled"></td><td><input type="button" id="btnChangePassword" value="changePassword"></td></tr>
				<tr><td><label>First Name</label></td><td><input type="text" id="firstName" name="firstName"></td></tr>
				<tr><td><label>Last Name</label></td><td><input type="text" id="lastName" name="lastName"></td></tr>
				<tr><td><label>Middle Initial</label></td><td><input type="text" id="middleInitial" name="middleInitial"></td></tr>
				<tr><td><label>Email Address</label></td><td><input type="text" id="email" name="email"></td></tr>
				<tr><td><label>Active Tag</label></td><td><input type="radio" name="activeTag" value="Y" checked="checked"><input type="radio" name="activeTag" value="N"></td></tr>
				<tr><td><label>Access Level</label></td><td><select id="accessLevel" name="accessLevel" >
																<option value=""></option>
																<option value="U">User</option>
																<option value="A">Admin</option>
														  	</select></td></tr>
			</table>
		</div>
		<div id="buttonsDiv">
			<input type="button" id="btnAddNew" value="Add New"><br>
			<input type="button" id="btnSave" value="Save"><br>
			<input type="button" id="btnCancel" value="Cancel">
		</div>
		<div id="searchDiv">
		<table>
			<tr><td><label>Search</label></td><td><input type="text" id="search" name="search"></td></tr>
		</table>
		<table border="1">
			<tr>
				<th>User ID</th>
				<th>First Name</th>
				<th>Last Name</th>
				<th>M.I.</th>
				<th>Email</th>
				<th>Active Tag</th>
				<th>Access Level</th>
				<th>Entry Date</th>
				<th>Last Login</th>
				<th>Last Updated By</th>
				<th>Last Update</th>
			</tr>
		</table>
			
		</div>
	</div>
</body>
<script>
</script>
</html>