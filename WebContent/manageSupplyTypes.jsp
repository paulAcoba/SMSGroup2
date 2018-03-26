<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
	pageEncoding="ISO-8859-1"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">

<script src="js/prototype.js"></script>
<title>Supply Type Maintenance</title>


<style>
#sId {
	text-decoration: underline;
	color: #4798f2;
}

body {
	background-color: #ccf3ff;
	font: 12px Arial;
}

div {
	background-color: white;
	width: 1000px;
	height: 500px;
	/* border: 25px solid green;
    padding: 25px; */
	margin: 50px 50px 50px 30px;
}

#supplyTypeTable {
	border-collapse: collapse;
	border: 1px solid black;
	width: 700px;
	font: 12px Arial;
	border-radius: 0px;
	box-shadow: 10px 10px 5px grey;
	text-align: center;
}

#sId, #sTn, #sD, #sLu, #sLud, .th1, .records {
	border: 1px solid black;
}

.records:hover {
	background-color: #d5d3d2;
	color: #4798f2;
}

input[type="button"] {
	background-color: #4798f2;
	width: 150px;
	font: 12px Arial;
	font-weight: bold;
}

#lblSearch {
	font: 12px Arial;
	margin-top: 2px;
	margin-bottom: 2px;
	margin-right: 2px;
	margin-left: 2px;
}

#topRight {
	position: absolute;
	top: 8px;
	right: 16px;
	font-size: 18px;
	font-weight: bold;
}
#topLeft {
    position: absolute;
    top: 8px;
    left: 16px;
}

#wrapper {
	position: relative;
}
#table1{
text-align: right;
}



/* for modal */


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
	height: 30%; /* Black w/ opacity */
}

/* Modal Content */
.modal-contentEmpty{
background-color: #ffcccc;
	margin: auto;
	padding: 20px;
	border: 1px solid #33cc33;
	width: 90%;
	height: 10%;
	border-radius: 10px;
}
.modal-content{
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
</style>
</head>
<body>
	
		<div id="wrapper">
		<%-- <jsp:include page="peripherals/nav.jsp"></jsp:include> --%>
			<b>Supply Type Maintenance</b>
			<table id="table1">
				<tr>
					<td>Supply Type ID</td>
					<td><input type="text" id="txtSupplyTypeId" disabled></td>
				</tr>
				<tr>
					<td>Supply Type Name</td>
					<td><input type="text" id="txtSupplyTypeName"></td>
				</tr>
				<tr>
					<td>&nbsp;</td>
					<td>&nbsp;</td>
				</tr>
				<tr>
					<td>&nbsp;</td>
					<td>&nbsp;</td>
				</tr>
				
				<tr>
					<td id="lblSearch"><label>Search</label><img
						src="images/search.ico" width="25px" height="25px" /></td>
					<td><input type="text" id="txtSearch"></td>
				</tr>
			</table>
			
			<table id="topRight">
				<tr>
					<td><input type="button" id="btnAddNewSupply" value="Add New"></td>
				</tr>
				<tr>
					<td><input type="button" id="btnSave" value="Save"></td>
				</tr>
				<tr>
					<td><input type="button" id="btnCancel" value="Cancel"></td>
				</tr>
			</table>
			
			
			
			<table id="topLeft">
				<tr>
					<td>Users</td>
				</tr>
				<tr>
					<td>Supply Types</td>
				</tr>
				<tr>
					<td>Supplies</td>
				</tr>
			</table>



			<br>


			<table id="supplyTypeTable">
				<tr>
					<th class="th1">Supply Type ID</th>
					<th class="th1">Supply Type Name</th>
					<th class="th1">Entry Date</th>
					<th class="th1">Last Updated By</th>
					<th class="th1">Last Update</th>
				</tr>

				<c:forEach var="sup" items="${suppliesType}">
					<tr class="records">
						<td id="sId"><c:out value="${sup.supplyTypeId}" /></td>
						<td id="sTn"><c:out value="${sup.typeName}" /></td>
						<td id="sD"><c:out value="${sup.entryDate}" /></td>
						<td id="sLu"><c:out value="${sup.lastUser}" /></td>
						<td id="sLud"><c:out value="${sup.lastUpdate}" /></td>
					</tr>
				</c:forEach>

			</table>
		</div>
	
 <div id="successfullyUpdatedModal" class="modal">
		<div class="modal-content">
			<span class="close">&times;</span>
			<p>Successfully updated! </p>
		</div>
	</div> 
	
	
 <div id="EmptyFieldsModal" class="modal">
		Modal content
		<div class="modal-contentEmpty">
			<span class="close">&times;</span>
			<p>Please complete the fields needed</p>
		</div>
	</div>	
</body>

<script>

 function showSuccessfullyUpdatedModal() {
	var modalf = document.getElementById('successfullyUpdatedModal');

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
 
 
   function showEmptyFieldsModal() {
		var modalEmpty = document.getElementById('EmptyFieldsModal');

		//Get the <span> element that closes the modal
		var span = document.getElementsByClassName("close")[0];

		//When the user clicks the button, open the modal 
		modalEmpty.style.display = "block";
		//When the user clicks on <span> (x), close the modal
		span.onclick = function() {
			modalEmpty.style.display = "none";
		}

		//When the user clicks anywhere outside of the modal, close it
		window.onclick = function(event) {
			if (event.target == modalEmpty) {
				modalEmpty.style.display = "none";
			}
		}
	}  


	function refresh() {
		new Ajax.Request("${pageContext.request.contextPath}"
				+ "/addSupplyType", {
			method : "GET",
			parameters : {
				action : "refresh"
			},
			onComplete : function(response) {
				$('supplyTypeTable').update(response.responseText);

			}
		});
	}

	$('txtSearch').observe(
			'keypress',
			function(event) {
				if (event.keyCode == Event.KEY_RETURN
						|| event.which == Event.KEY_RETURN) {
					//
					new Ajax.Request("${pageContext.request.contextPath}"
							+ "/addSupplyType", {
						method : "GET",
						parameters : {
							action : "search",
							supplyTypeId : $F("txtSearch")
						},
						onComplete : function(response) {
							$('supplyTypeTable').update(response.responseText);
						}
					})
					Event.stop(event);
				}
			});

	$("btnAddNewSupply").observe(
			"click",
			function() {
				new Ajax.Request("${pageContext.request.contextPath}"
						+ "/addSupplyType", {
					method : "GET",
					parameters : {
						action : "addNewSupply"
					},
					onComplete : function(response) {
						$("wrapper").update(response.responseText);
					}
				})
			});

	$("btnSave").observe("click", function() {
				
				if($F("txtSupplyTypeName")=="" ||  $F("txtSupplyTypeId") == ""){
					showEmptyFieldsModal();
				}else{
					new Ajax.Request("${pageContext.request.contextPath}"
							+ "/addSupplyType", {
						method : "GET",
						parameters : {
							action : "updateSupplyType",
							supplyTypeId : $F("txtSupplyTypeId"),
							supplyTypeName : $F("txtSupplyTypeName")
						},
						onComplete : function(response) {
							
							//alert(response.responseText);
							//refresh();
							showSuccessfullyUpdatedModal();
							$('supplyTypeTable').update(response.responseText);
							$("txtSupplyTypeId").value = "";
							$("txtSupplyTypeName").value = "";
						}
					});
				}
				
				
			});

	var table = $('supplyTypeTable');
	for (var i = 1; i < table.rows.length; i++) {
		table.rows[i].onclick = function() {
			$("txtSupplyTypeId").value = this.cells[0].innerHTML;
			$("txtSupplyTypeName").value = this.cells[1].innerHTML;
		};
	}
</script>
</html>