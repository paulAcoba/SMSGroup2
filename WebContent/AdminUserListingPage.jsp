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
<title>User Listing</title>
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
					<tr><td><label>User ID</label></td><td><input type="text" id="userId" name="userId" disabled="disabled"></td></tr>
					<tr><td><label>Password</label></td><td><input type="password" id="password" name="password" disabled="disabled"></td>
					<tr><td><label>First Name</label></td><td><input type="text" id="firstName" name="firstName"></td></tr>
					<tr><td><label>Last Name</label></td><td><input type="text" id="lastName" name="lastName"></td></tr>
					<tr><td><label>Middle Initial</label></td><td><input type="text" id="middleInitial" name="middleInitial"></td></tr>
					<tr><td><label>Email Address</label></td><td><input type="email" placeholder="default@example.com" id="email" name="email"></td></tr>
					<tr><td><label>Active Tag</label></td><td><input type="radio" id="activeTagYes" name="activeTag" value="Y" checked="checked">Yes<input type="radio" id="activeTagNo" name="activeTag" value="N">No</td></tr>
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
		</form>
		<div id="searchDiv">
			<table>
				<tr><td><label>Search</label></td><td><input type="text" id="search" name="search"></td></tr>
			</table>
			<table id="searchTable" border="1">
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

	if("${serviceResponse}" == "emptyField") {
		$("modalP").update("One or more fields are empty. Please complete all fields.");
		$("myModal").writeAttribute("style", "display:block");
	}

	if("${serviceResponse}" == "okay") {
		$("modalP").update("The changes were successfully saved.");
		$("myModal").writeAttribute("style", "display:block");
	}
	
	$("btnSave").observe("click", function(){
		
		var activeTag = "";
		if($("activeTagYes").checked){
			activeTag = "Y";
		} else if($("activeTagNo").checked){
			activeTag = "N";
		}
		
		new Ajax.Request(contextPath + "/updateprofile", {
			method: "POST",
			parameters: {
				userType: "admin",
				userId: $F("userId"),
				firstName: $F("firstName"),
				lastName: $F("lastName"),
				email: $F("email"),
				middleInitial: $F("middleInitial"),
				activeTag: activeTag,
				accessLevel: $F("accessLevel")
			},
			onComplete: function(response) {
				$("wrapper").update(response.responseText);
			}
		});
	});
	
	$("btnAddNew").observe("click", function(){
		new Ajax.Request(contextPath + "/gate", {
			method: "POST",
			parameters: {
				gateKey: "adminAddNewUser"
			},
			onComplete: function(response){
				$("wrapper").update(response.responseText);
			}
		});
	});
	
	$("search").observe("keyup", function(){
		
		new Ajax.Request(contextPath + "/search", {
			method: "POST",
			parameters: {
				keyword: $F("search")
			},
			onComplete: function(response) {
				$("searchTable").update(response.responseText);
			}
		});
	});
	$("searchTable").observe("mouseover", function() {
		$$("tr.rows").each(function(r){
			$(r.id).observe("mouseover", function() {
				$$("tr.rows").each(function(row){
					$(row.id).observe("click", function(){
						$("userId").value = $(row.id).down(0).innerHTML;
						$("firstName").value = $(row.id).down(1).innerHTML;
						$("lastName").value = $(row.id).down(2).innerHTML;
						$("middleInitial").value = $(row.id).down(3).innerHTML;
						$("email").value = $(row.id).down(4).innerHTML;
						$("accessLevel").value = $(row.id).down(6).innerHTML;
						$("password").value = $(row.id).down(11).innerHTML;
						if($(row.id).down(5).innerHTML == "Y") {
							$("activeTagYes").writeAttribute("checked", "checked");
						} else if($(row.id).down(5).innerHTML == "N") {
							$("activeTagNo").writeAttribute("checked", "checked");
						}
					});
				});	
			});
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