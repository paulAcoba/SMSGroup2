<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
<title>Runner</title>
<link rel="stylesheet" href="css/UserManagementStyle.css" type="text/css">
<script src="js/prototype.js"></script>
<script> var contextPath = "${pageContext.request.contextPath}";</script>
</head>
<body>
	<div id="wrapper">
		<form action="javascript: enter()" method="POST">
			<div id="formDiv">
				<label>userId</label><input type="text" id="userId" name="userId">
				<label>password</label><input type="password" id="password" name="password">
			</div>
			<div id="buttonsDiv">
				<input type="submit" value="Enter">
			</div>
		</form>
	</div>
</body>
<script>
	function enter() {
		new Ajax.Request(contextPath + "/enter", {
			method: "POST",
			parameters: {
				userId: $F("userId"),
				password: $F("password")
			},
			onComplete: function(response) {
				$("wrapper").update(response.responseText);
			}
		});
	}
</script>
</html>