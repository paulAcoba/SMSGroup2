<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
	pageEncoding="ISO-8859-1"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
<title>Insert title here</title>
<script src="js/prototype.js"></script>


<style>
#wrapper {
	position: relative;
}
/* input[type="button"] {
	background-color: #4798f2;
	width: 150px;
	color: white;
	font: 12px Arial;
	font-weight: bold;
}

body {
	background-color: #ccf3ff;
	font: 12px Arial;
}

div {
	background-color: white;
	width: 1000px;
	height: 500px;
	margin: 50px 50px 50px 30px;
}

#topRight {
	position: absolute;
	top: 20px;
	right: 16px;
	font-size: 18px;
	font-weight: bold;
}

#topLeft {
	position: absolute;
	top: 8px;
	left: 16px;
	font-weight: bold;
}

#wrapper {
	position: relative;
}

#table1 {
	text-align: right;
}
 */
#topRight {
	position: absolute;
	top: 62px;
	right: 22px;
	font-size: 18px;
	font-weight: bold;
}
.buttons td button{
	width: 100%;
	font:  Arial;
	font-weight: bold;
}
/* 
d */
.modal {
	display: none;
	position: fixed; /* Stay in place */
	z-index: 1; /* Sit on top */
	padding-top: 100px; /* Location of the box */
	left: 0;
	top: 0;
	width: 100%; /* Full width */
	height: 100%; /* Full height */
	overflow: auto; /* Enable scroll if needed */
	background-color: rgba(0, 0, 0, 0.4); /* Fallback color */
	background-color: rgba(0, 0, 0, 0.4);
	height: 100%; /* Black w/ opacity */
}

/* Modal Content */
.modal-content {
	background-color: #ffcccc;
	margin: auto;
	padding: 20px;
	border: 1px solid #33cc33;
	width: 90%;
	height: 10%;
	border-radius: 10px;
}

.modal-contentSuccess {
	background-color: #adebad;
	margin: auto;
	padding: 20px;
	border: 1px solid #33cc33;
	width: 90%;
	height: 10%;
	border-radius: 10px;
}

/* The Close Button */
.close {
	color: #aaaaaa;
	float: right;
	font-size: 28px;
	font-weight: bold;
}

.close:hover, .close:focus {
	color: red;
	text-decoration: none;
	cursor: pointer;
}
/* #myEmptyFieldsModal{height:50px;background-color:green;} */

.hidden{
	visibility:hidden;
}

.show{
	visibility:visible;
}
</style>

</head>
<body>




	<center>
		<div id="wrapper"><!-- 
			<b>Supply Type Maintenance</b> -->
			<div class="panel panel-info">
				<div class="panel-heading">Supply Type Maintenance</div>
				<div class="panel-body">
				 <div class="alert alert-danger " id="alertf" hidden>
				 <a href="#" class="close" data-dismiss="alert" aria-label="close">&times;</a>
    				<strong>Danger!</strong> Please complete the fields needed.
				 </div> 
				 
				<div class="alert alert-success alert-dismissible" id="alert" hidden>
				 <a href="#" class="close" data-dismiss="alert" aria-label="close">&times;</a>
    				<strong>Success!</strong> Successfully added.
				</div>
					<table id="table1">
						
						<tr class="buttons">
							<td>Supply Type ID</td>
							<td><input type="text" id="txtSupplyTypeId"
								value="${maxSupplyTypeId}" class="form-control" disabled></td>
								<td>&nbsp;</td>
								<td><button type="button" class="btn btn-primary" id="btnSave"><span class="glyphicon glyphicon-ok"></span> Save</button></td>
						</tr>
						<tr class="buttons">
							<td>Supply Type Name</td>
							<td><input type="text" class="form-control" id="txtSupplyTypeName"></td>
							<td>&nbsp;</td>
							<td><button type="button" class="btn btn-danger" id="btnCancel"><span class="glyphicon glyphicon-remove"></span> Cancel</button></td>
						</tr>
						
					</table>
					
			
				</div>
			</div>
			

		</div>
	</center>


<!-- 
	<div id="myEmptyFieldsModal" class="modal">
		Modal content
		<div class="modal-content">
			<span class="close">&times;</span>
			<p>Please complete the fields needed</p>
		</div>
	</div>

	<div id="successfullyAddedModal" class="modal">
		Modal content
		<div class="modal-contentSuccess">
			<span class="close">&times;</span>
			<p>Successfully added</p>
		</div>

	</div> -->
</body>

<script>
	/* function showModal1() {
		var modals = document.getElementById('successfullyAddedModal');

		//Get the <span> element that closes the modal
		var span = document.getElementsByClassName("close")[0];

		//When the user clicks the button, open the modal 
		modals.style.display = "block";
		//When the user clicks on <span> (x), close the modal
		span.onclick = function() {
			modals.style.display = "none";
		}

		//When the user clicks anywhere outside of the modal, close it
		window.onclick = function(event) {
			if (event.target == modals) {
				modals.style.display = "none";
			}
		}
	}
	//showModal();
	function showModal() {
		var modalf = document.getElementById('myEmptyFieldsModal');

		//Get the <span> element that closes the modal
		var span = document.getElementsByClassName("close")[0];

		//When the user clicks the button, open the modal 
		modalf.style.display = "block";
		//When the user clicks on <span> (x), close the modal
		span.onclick = function() {
			modalf.style.display = "none";
		}

		//When the user clicks anywhere outside of the modal, close it
		window.onclick = function(event) {
			if (event.target == modalf) {
				modalf.style.display = "none";
			}
		}
	}
 */
	//
	$("btnSave").observe(
			"click",
			function() {

				if ($F("txtSupplyTypeName") == "") {
					//$("main").update(response.responseText);
					//modal.style.display = "block";
					//showModal();
					//alert("hgi");
					
					$('alertf').className += ' show';
					//$('alertf').update("Please");
				} else {
					new Ajax.Request("${pageContext.request.contextPath}"
							+ "/addSupplyType", {
						method : "GET",
						parameters : {
							action : "save",
							supplyTypeId : $F("txtSupplyTypeId"),
							supplyTypeName : $F("txtSupplyTypeName")
						},
						onComplete : function(response) {
							//showModal1();
							$("wrapper").update(response.responseText);
							$('alert').className += ' show';
							//$("txtSupplyTypeId").value = "";
							$("txtSupplyTypeName").value = "";
							//$('alert').update("Data Saved");
						}
					});
				}

			});

	$("btnCancel").observe(
			"click",
			function() {
				new Ajax.Request("${pageContext.request.contextPath}"
						+ "/addSupplyType", {
					method : "GET",
					parameters : {
						action : "cancel"

					},

					onComplete : function(response) {
						$("wrapper").update(response.responseText);
					}
				})
			});
</script>
</html>