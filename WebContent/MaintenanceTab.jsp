<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<script src="js/prototype.js"></script>
<script> var contextPath = "${pageContext.request.contextPath}";</script>
<jsp:include page="peripherals/header.jsp"></jsp:include>
<link rel="stylesheet" href="css/UserManagementStyle.css" type="text/css">
<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
<title>Maintenance Tab</title>
</head>
<body>
	<jsp:include page="peripherals/nav.jsp"></jsp:include>
	<div id="maintenanceTab" class="list-group">
		<div id="userMaintenance" class="list-group-item">User Maintenance</div>
		<div id="supplyTypes" class="list-group-item">Supply Types</div>
		<div id="supplies" class="list-group-item">Supplies</div>
	</div>
	<div id = "wrapper" style="display:inline-block;">
	</div>
</body>
<script>
	
	$("userMaintenance").observe("click", function(){
		new Ajax.Request(contextPath + "/AdminUserListingPage.jsp", {
			method: "POST",
			parameters: {
				gateKey: "adminUserListing"
			},
			onComplete: function(response) {
				$("wrapper").update(response.responseText);
				$("supplyTypes").className = "list-group-item";
				$("supplies").className = "list-group-item";
				$("userMaintenance").className = "list-group-item active";
			}
		});
	});
	
	$("supplies").observe("click", function(){
		new Ajax.Request(contextPath + "/suppliesmaintenance.jsp", {
			method: "POST",
			parameters: {
				gateKey: "adminUserListing"
			},
			onComplete: function(response) {
				$("wrapper").update(response.responseText);
				$("supplyTypes").className = "list-group-item";
				$("userMaintenance").className = "list-group-item";
				$("supplies").className = "list-group-item active";
			}
		});
	});
	
	$("supplyTypes").observe("click", function(){
		new Ajax.Request(contextPath + "/addSupplyType", {
			method: "GET",
		
			onComplete: function(response) {
				$("wrapper").update(response.responseText);
				$("userMaintenance").className = "list-group-item";
				$("supplies").className = "list-group-item";
				$("supplyTypes").className = "list-group-item active";
			}
		});
	});
</script>
</html>