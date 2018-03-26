<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<jsp:include page="../peripherals/header.jsp"></jsp:include>
<link rel="stylesheet" type="text/css"
	href="../css/suppliesmaintenance.css">
<title>Supplies Maintenance</title>
<script>
	window.onload = function() {
		populate();
	}
</script>
</head>

<body>
	<div id="wrapper">
		<jsp:include page="../peripherals/nav.jsp"></jsp:include>
		<fieldset title="Supplies Maintenance" id="supplyMaintenances">

			<div id="dataForm">
				<table id="dataFormTable">

					<tr>
						<td><input type="text" id="txtsuppId" hidden></td>
					</tr>
					<tr>


						<!-- 	<td><label>Supply Type: </label></td>
						<td><input type="text" id="txtsuType"></td> -->


						<td><label>Supply Type:</label></td>
						<td><select id="txtsuType" disabled="disabled">
								<%-- <c:forEach var="itList" items="${supType}">
									<option value="${itList.supplyType}"><c:out
											value="${itList.typeName}"></c:out></option>
								</c:forEach> --%>
						</select></td>


					</tr>
					<tr>
						<td><label>Item Name:</label></td>
						<td><input type="text" id="txtitName" disabled></td>
					</tr>
					<tr>
						<td><label>Item Unit:</label></td>
						<td><input type="text" id="txtitUnit" disabled="disabled"></td>
					</tr>
					<tr>
						<td><label>Obsolete Tag:</label></td>
						<td><form>
								<input type="radio" name="obsolete" value="Y" id="rdYes"
									disabled>Yes <input type="radio" name="obsolete"
									value="N" id="rdNo" disabled>No
							</form></td>
					</tr>
					<tr>
						<td><label>Location:</label></td>
						<td><input type="text" id="txtlocation" disabled="disabled"></td>
					</tr>
					<tr>
						<td><label>Entered Date:</label></td>
						<td><input type="date" id="dateEntered" disabled="disabled"></td>
					</tr>

					<tr>
						<td><label>Reorder Level:</label></td>
						<td><input type="text" id="txtreLevel"
							onkeydown='return (event.which >=48 && event.which <=57) || event.which ===8 || event.which == 46'
							disabled> <label>Actual Count: </label> <input
							type="text" class="quantity" id="txtacCount"
							onkeydown='return (event.which >= 48 && event.which <= 57) 
   || event.which == 8 || event.which == 46'
							disabled /> <!-- <input type="text" id="txtacCount"
							disabled="disabled"></td> -->
					</tr>

					<tr>
						<form>
							<td><label>Remarks :</label></td>
							<td><textarea rows="5" cols="30" id="remarks" disabled>
							</textarea></td>
						</form>


					</tr>
					<tr>
						<td colspan="2"><input type="button" name="btnAddshow"
							id="btnAddshow" value="Add New"> <input type="button"
							name="btnSave" id="btnSave" value="Save"> <input
							type="button" name="btnCancel" id="btnCancel" value="Cancel"></td>
					</tr>
				</table>
			</div>
			<div id="supplyMaintenanceTable" class="tableDiv">
				<label>Search: </label> <input type="text" name="txtSearch"
					id="txtSearch" placeholder="Supply ID"><br />
				<table id="dataTable" border="1">
					<%-- <tr id="dataTableHeader">
						<th>Supply ID</th>
						<th>Supply Type</th>
						<th>Item Name</th>
						<th>Item Unit</th>
						<th>Obsolete Tag</th>
						<th>Location</th>
						<th>Reorder Level</th>
						<th>Actual Count</th>
						<th>Remarks</th>
						<th>Entry Date</th>
						<th>Last Updated By</th>
						<th>Last Update</th>
					</tr>
					<c:forEach var="items" items="${allItems}">
						<tr id="${items.supplyId}">
							<td><c:out value="${items.supplyId}"></c:out></td>
							<td><c:out value="${items.supplyType}"></c:out></td>
							<td><c:out value="${items.itemName}"></c:out></td>
							<td><c:out value="${items.itemUnit}"></c:out></td>
							<td><c:out value="${items.obsoleteTag}"></c:out></td>
							<td><c:out value="${items.location}"></c:out></td>
							<td><c:out value="${items.reorderLevel}"></c:out></td>
							<td><c:out value="${items.actualCount}"></c:out></td>
							<td><c:out value="${items.remarks}"></c:out></td>
							<td><fmt:formatDate type="date" pattern="yyyy-MM-dd"
									value="${items.dateAdded}"></fmt:formatDate></td>
							<td><c:out value="${items.lastUser}"></c:out></td>
							<td><fmt:formatDate type="date" pattern="yyyy-MM-dd"
									value="${items.lastUpdate}"></fmt:formatDate></td>
						</tr>
					</c:forEach> --%>
				</table>
			</div>
		</fieldset>
	</div>
</body>
</html>
<script>
	try {
		function populate() {
			new Ajax.Request(contextPath + "/supplymaintenance", {
				method : "POST",
				parameters : {
					action : "populate"
				},
				onComplete : function(response) {
					$('dataTable').update(response.responseText);

					select()
					sTypeId();

				}

			});
		}

		function sTypeId() {
			new Ajax.Request(contextPath + "/supplymaintenance", {
				method : "POST",
				parameters : {
					action : "id"
				},
				onComplete : function(response) {
					$('txtsuType').update(response.responseText);
				}
			});
		}

		$('btnAddshow').observe("click", function() {
			alert('test');
			new Ajax.Request(contextPath + "/supplymaintenance", {
				method : "POST",
				parameters : {
					action : "showSupply",
				/* 	 	supplyType : $F('txtsuType'),
							itemName : $F('txtitName'),
							itemUnit : $F('txtitUnit'),
							obsoleteTag : $F('rdYesNo'),
							location : $F('txtlocation'),
							reorderLevel : $F('txtreLevel'),
							remarks : $F('remarks'),
							actualCount : $F('txtacCount'),
							dateAdded : $F('dateEntered') */

				},
				onComplete : function(response) {
					$('supplyMaintenances').update(response.responseText);
					sTypeId();
					//$('supplyMaintenances').update(response.responseText);

				}
			});
		});
		$('btnCancel').observe("click", function() {
			clear();
		});

		$('btnSave').observe("click", function() {

			if (!$F('txtitName') || !$F('txtitUnit') || !$F('txtacCount')) {
				alert("Please fill up all the fields!");
			} else {

				var obsolete = "";
				if ($("rdYes").checked) {
					obsolete = "Y";
				} else if ($("rdNo").checked) {
					obsolete = "N"
				}

				new Ajax.Request(contextPath + "/supplymaintenance", {
					method : "POST",
					parameters : {
						action : "save",
						supplyId : $F('txtsuppId'),
						itemName : $F('txtitName'),
						itemUnit : $F('txtitUnit'),
						obsoleteTag : obsolete,
						location : $F('txtlocation'),
						reorderLevel : $F('txtreLevel'),
						remarks : $F('remarks'),
						actualCount : $F('txtacCount')

					},
					onComplete : function(response) {
						populate();
						alert('supplies updated');
						disabled()
					}
				});
			}
		})

		function clear() {
			$('txtsuType').value = '';
			$('txtitName').value = '';
			$('txtitUnit').value = '';
			$('rdYes').checked = false;
			$('rdNo').checked = false;
			$('txtlocation').value = '';
			$('txtreLevel').value = '';
			$('txtacCount').value = '';
			$('dateEntered').value = '';
			$('remarks').value = '';
			$('txtSearch').value = '';
			populate();
			//sTypeId();
		}

		function enabled() {
			document.getElementById('txtitName').disabled = false;
			document.getElementById('txtitUnit').disabled = false;
			document.getElementById('rdYes').disabled = false;
			document.getElementById('rdNo').disabled = false;
			document.getElementById('txtlocation').disabled = false;
			document.getElementById('txtreLevel').disabled = false;
			document.getElementById('txtacCount').disabled = false;
			document.getElementById('remarks').disabled = false;

			//--------------REPLACE DOLLAR SIGN
		}

		function disabled() {
			document.getElementById('txtitName').disabled = true;
			document.getElementById('txtitUnit').disabled = true;
			document.getElementById('rdYes').disabled = true;
			document.getElementById('rdNo').disabled = true;
			document.getElementById('txtlocation').disabled = true;
			document.getElementById('txtreLevel').disabled = true;
			document.getElementById('txtacCount').disabled = true;
			document.getElementById('remarks').disabled = true;

			//--------------REPLACE DOLLAR SIGN
		}

		function select() {
			var table = $('dataTable');

			for (var i = 1; i < table.rows.length; i++) {
				table.rows[i].onclick = function() {

					$('txtsuppId').value = this.cells[0].innerHTML;
					var supplyTypeId = this.cells[1].children[0].value;

					$('txtsuType').value = supplyTypeId;

					$('txtitName').value = this.cells[2].innerHTML;
					$('txtitUnit').value = this.cells[3].innerHTML;

					//$('rdYesNo').value = this.cells[4].innerHTML;
					$('txtlocation').value = this.cells[5].innerHTML;
					$('txtreLevel').value = this.cells[6].innerHTML;
					$('txtacCount').value = this.cells[7].innerHTML;
					$('remarks').value = this.cells[8].innerHTML;
					$('dateEntered').value = this.cells[9].innerHTML;
					if (this.cells[4].innerHTML == "Y") {
						$("rdYes").writeAttribute("checked", "checked");
					} else if (this.cells[4].innerHTML == "N") {
						$("rdNo").writeAttribute("checked", "checked");
					}

					enabled()

				}
			}
		}

		$('txtSearch').observe("keyup", function() {
			populate("search");
			new Ajax.Request(contextPath + "/supplymaintenance", {
				method : "POST",
				parameters : {
					action : "search",
					search : $F('txtSearch')
				},
				onComplete : function(response) {
					$('dataTable').update(response.responseText);
					select();
				}
			});

		});

	} catch (e) {
		alert("home.jsp " + e);
	}
</script>

