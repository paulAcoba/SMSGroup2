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
#supplyTypeTable {
	border-collapse: collapse;
	width: 100%;
	font: 12px Arial;
	border-radius: 0px;
	/* box-shadow: 10px 10px 5px grey; */
	text-align: center;
}

#sId, #sTn, #sD, #sLu, #sLud, .th1, .records {
	/* border: 1px solid black; */
}

.buttons td button{
	width: 100%;
	font:  Arial;
	font-weight: bold;
}

.records:hover {
	background-color: #d5d3d2;
	color: #4798f2;
}

/* input[type="button"] {
	width: 150px;
	font: 12px Arial;
	font-weight: bold;
} */

#lblSearch {
	font: 12px Arial;
	margin-top: 2px;
	margin-bottom: 2px;
	margin-right: 2px;
	margin-left: 2px;
}

#topRight {
	position: absolute;
	top: 62px;
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

#table1 {
	text-align: right;
}

* /
	/* for modal */ 

//end
.hidden{
	visibility:hidden;
}

.show{
	visibility:visible;
}
</style>
</head>
<body>

	<div id="wrapper">
		<div class="panel panel-info">
			<div class="panel-heading">Supply Type Maintenance</div>
			<div class="panel-body">
			
			<div class="alert alert-warning alert-dismissible " id="alertf" hidden>
				 <a href="#" class="close" data-dismiss="alert" aria-label="close">&times;</a>
    				<strong>Danger!</strong> Select a record to update.
				 </div> 
			
			
			<div class="alert alert-success alert-dismissible" id="alert" hidden>
				 <a href="#" class="close" data-dismiss="alert" aria-label="close">&times;</a>
    				<strong>Success!</strong> Successfully updated.
				</div>
				<%-- <jsp:include page="peripherals/nav.jsp"></jsp:include> --%>
				<center>
				<table id="table1" >
					<tr class="buttons">
						<td>Supply Type ID</td>
						<td><input type="text" id="txtSupplyTypeId" class="form-control" disabled></td>
						<td>&nbsp;</td>
						<td ><button type="button" id="btnAddNewSupply"
							class="btn btn-success"><span class="glyphicon glyphicon-plus"> Add New</span></button>
							</td>
					</tr>
					<tr class="buttons">
						<td>Supply Type Name</td>
						<td><input type="text" id="txtSupplyTypeName" class="form-control"></td>
						<td>&nbsp;</td>
						<td ><button type="button" id="btnSave"
							class="btn btn-primary"><span class="glyphicon glyphicon-ok"> Save</span></button>
							</td>
					</tr>
					<tr class="buttons">
						<td>&nbsp;</td>
						<td>&nbsp;</td>
						<td>&nbsp;</td>
						<td ><button type="button" class="btn btn-danger" id="btnCancel"><span class="glyphicon glyphicon-remove"></span> Cancel</button></td>
					</tr>
					<tr>
						<td>&nbsp;</td>
						<td>&nbsp;</td>
						<td>&nbsp;</td>
					</tr>

					<tr>
						
						<td id="lblSearch" ><label>Search</label><img
							src="images/search.ico" width="25px" height="25px" /></td>
						<td><input type="text" id="txtSearch" class="form-control"></td>
						<td>&nbsp;</td>
					</tr>
				</table>
				</center>



				<br>
			</div>
		</div>
				<table id="supplyTypeTable" class="table table-hover">
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

	<%-- <div id="successfullyUpdatedModal" class="modal">
		<div class="modal-content">
			<span class="close">&times;</span>
			<p>Successfully updated!</p>
		</div>
	</div>


	<div id="EmptyFieldsModal" class="modal">
		Modal content
		<div class="modal-contentEmpty">
			<span class="close">&times;</span>
			<p>Please complete the fields needed</p>
		</div>
	</div>
	
	
	
	<c:if test="${supplyTypeIdNotFound != null}">
		<div id="EmptyFieldsModal" class="modal">
		Modal content
		<div class="modal-contentEmpty">
			<span class="close">&times;</span>
			<p>Please </p>
		</div>
	</div>
	</c:if> --%>
</body>

<script>
	/* function showSuccessfullyUpdatedModal() {
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
	} */

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

	$("btnSave").observe(
			"click",
			function() {

				if ($F("txtSupplyTypeName") == ""
						|| $F("txtSupplyTypeId") == "") {
					//showEmptyFieldsModal();
					
					$('alertf').className += ' show';
				} else {
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
							//showSuccessfullyUpdatedModal();
							
							$('supplyTypeTable').update(response.responseText);
							
							$("txtSupplyTypeId").value = "";
							$("txtSupplyTypeName").value = "";
							$('alert').className += ' show';
						}
					});
				}

			});
	
	$("btnCancel").observe(
			"click",
			function() {
				new Ajax.Request("${pageContext.request.contextPath}"
						+ "/home", {
					method : "GET",
					parameters : {
						action : "cancel"

					},

					onComplete : function(response) {
						$("txtSupplyTypeId").value = "";
						$("txtSupplyTypeName").value = "";
					}
				})
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