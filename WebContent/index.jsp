<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
	pageEncoding="ISO-8859-1"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
<link rel="stylesheet" type="text/css" href="css/design.css">
<%-- <jsp:include page="peripherals/header.jsp"></jsp:include> --%>
<title>Login</title>

<script src="js/prototype.js"></script>

<script>
	var contextPath = "${pageContext.request.contextPath}";
</script>

</head>
<body>
	<div id="wrapper">
		<input type="hidden" id="hidStatus" value="${status? '':status }">
		<input type="hidden" id="hidPage" value="${page? '':page }">
		<fieldset class = "loginMenu" style="width: 215px;">
			<legend>
				<b><i>LOGIN</i></b>
			</legend>
			<table>
				<tr>
					<td><input type="text" id="log_username"
						placeholder="Username"></td>
				</tr>
				<tr>
					<td><input type="password" id="log_password"
						placeholder="Password"></td>
				</tr>
				<tr>
					<td><input type="button" id="btnLogin"
						value="LOGIN TO YOUR ACCOUNT"></td>
				</tr>
				
			</table>
			<div id="incorrect/blocked"></div>
		</fieldset>
		 <img src="css/SpinningGlobe.gif" alt="GlobeDesign" class="pic">
	</div>

</body>
</html>

<script>
try{
	

var counter = 0;
/* window.onload = function(){
	console.log($F('hidStatus')+"-hidden");
	if($F('hidStatus')=='login'){
		alert("hidden");
	}
}  */
$("btnLogin").observe("click", function() {
	login();
});

function login(){
	new Ajax.Request(contextPath + "/login", {
		method : "POST",
		parameters : {
			action: "updateUser",
			username : $F('log_username'),
			password : $F('log_password')
		},
		onFailure : function(response){
			$("incorrect/blocked").update(response.responseText);
		},
		onSuccess : function(response) {

			$("wrapper").update(response.responseText);
			
		}
	});
}	

}catch(e){
	console.log(e)
}
</script>