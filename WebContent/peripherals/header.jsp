<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="ISO-8859-1" import="com.cpi.servlet.*" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<script type="text/javascript" src="js/prototype.js"></script>
<script src="js/jquery-3.3.1.js" ></script>
<link rel="stylesheet" type="text/css" href="css/bootstrap/bootstrap.css" media="all">
<link rel="stylesheet" type="text/css" href="css/bootstrap/bootstrap.min.css" media="all">
<link rel="stylesheet" type="text/css" href="css/nav.css">
<script>
	jQuery.noConflict();
	window.onload = function(){
		refresh();
	}
	try{
		var contextPath = "${pageContext.request.contextPath}";	
	}catch(e){
		alert("supplies.jsp ", e);
	}
</script>	