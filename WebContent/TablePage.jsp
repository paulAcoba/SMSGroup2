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
<title>Table</title>
</head>
<body>
	<div id="searchTable">
		
	</div>
</body>
<script>
	var content = "${content}";
	var split = [];
	var finalContent = "";
	split = content.split("<br>");
	
	for(var i = 0; i < split.length; i++) {
		var newContent = split[i].replace(".class.", "class=\"rows\"");
		finalContent += newContent.replace(".id.", "id=\"row" + (i+1) + "\"");
	}
	
	$("searchTable").innerHTML = finalContent;
</script>
</html>