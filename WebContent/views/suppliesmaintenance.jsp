<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<jsp:include page="../peripherals/header.jsp"></jsp:include>
<link rel="stylesheet" type="text/css"
	href="css/suppliesmaintenance.css">
<title>Supplies Maintenance</title>
<script>
	window.onload = function() {
		populate();
	}
</script>
</head>

<body>
	<div id="wrapper">
		<div class="container">
			<fieldset title="Supplies Maintenance" id="supplyMaintenances">

				<div id="dataForm" class="panel panel-info">
					<div class="panel-heading">Supply Maintenance</div>
					<div class="panel-body">
						<div class="alert alert-danger" id="alert" hidden>${message}</div>
						<table id="dataFormTable">

							<tr>
								<td><input type="text" id="txtsuppId" hidden></td>
							</tr>
							<tr>


								<!-- 	<td><label>Supply Type: </label></td>
						<td><input type="text" id="txtsuType"></td> -->


								<td><label>Supply Types:</label></td>
								<td><select id="txtsuType" disabled="disabled"
									class="form-control">
										<%-- <c:forEach var="itList" items="${supType}">
									<option value="${itList.supplyType}"><c:out
											value="${itList.typeName}"></c:out></option>
								</c:forEach> --%>
								</select></td>


							</tr>
							<tr>
								<td><label>Item Name:</label></td>
								<td><input type="text" id="txtitName" disabled
									class="form-control"></td>
							</tr>
							<tr>
								<td><label>Item Unit:</label></td>
								<td><input type="text" id="txtitUnit" disabled="disabled"
									class="form-control"></td>
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
								<td><input type="text" id="txtlocation" disabled="disabled"
									class="form-control"></td>
							</tr>
							<tr>
								<td><label>Entered Date:</label></td>
								<td><input type="date" id="dateEntered" disabled="disabled"
									class="form-control"></td>
							<tr>
								<td><label>Reorder Level:</label></td>
								<td><input type="text" id="txtreLevel"
									onkeydown='return (event.which >=48 && event.which <=57) || event.which ===8 || event.which == 46'
									disabled class="form-control"></td>
							</tr>
							<tr>
								<td><label>Actual Count: </label></td>
								<td><input type="text" id="txtacCount"
									onkeydown='return (event.which >= 48 && event.which <= 57) 
   || event.which == 8 || event.which == 46'
									disabled class="form-control"></td>
								<!-- <input type="text" id="txtacCount"
							disabled="disabled"></td> -->
							</tr>

							<tr>
								<form>
									<td><label>Remarks :</label></td>
									<td><textarea rows="5" cols="30" id="remarks" disabled
											class="form-control">
							</textarea></td>
								</form>


							</tr>
							<tr>
								<td colspan="2"><input type="button" name="btnAddshow"
									id="btnAddshow" value="Add New" class="btn btn-success">
									<input type="button" name="btnSave" id="btnSave" value="Save"
									class="btn btn-primary"> <input type="button"
									name="btnCancel" id="btnCancel" value="Cancel"
									class="btn btn-danger"></td>
							</tr>
						</table>
					</div>
				</div>
				<div id="supplyMaintenanceTable" class="tableDiv">
					<label>Search: </label> <input type="text" name="txtSearch"
						id="txtSearch" placeholder="Supply ID" class="form-control"><br />
					<table id="dataTable" class="table table-hover">
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
		populate();
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
					//$('wrapper').update(response.responseText);
					$('supplyMaintenances').update(response.responseText);
					sTypeId();

				}
			});
		});
		$('btnCancel').observe("click", function() {
			$('btnAddshow').disabled = false;
			clear();
			disabled();
		});

		$('btnSave').observe("click", function() {
			
			if ($('txtitUnit').disabled == true) {
				$('alert').className += ' show';
				$('alert').update('Please Select an Item'); 
			
			}else if (!$F('txtsuType') || !$F('txtitName') || !$F('txtitUnit') || !$F('txtacCount')) {
				$('alert').className += ' show';
				$('alert').update("Please fill up all the fields!");
				
			
			}else if ($F('txtitName').length > 100 ) {
				$('alert').className += ' show';
				$('alert').update('The letters of the item name entered should not exceed to 100');

			}  else if ($F('txtitUnit').length > 10 ) {
				$('alert').className += ' show';
				$('alert').update('The letters of the item unit entered should not exceed to 10');

			}  else if ($F('txtlocation').length > 100 ) {
				$('alert').className += ' show';
				$('alert').update('The letters of the location entered should not exceed to 100');

			}  else if ($F('remarks').length > 1000 ) {
				$('alert').className += ' show';
				$('alert').update('The letters of the remarks entered should not exceed to 1000');

			} else if ($F('txtreLevel').length > 4 || $F('txtacCount').length > 4 ) {
				$('alert').className += ' show';
				$('alert').update('The inpputed numbers should only contain 4 digits');
			}else if (isNaN($F('txtreLevel')) || isNaN($F('txtacCount'))) {
				$('alert').className += ' show';
				$('alert').update('Enter proper number'); 
			
			}else {
				$('alert').className = 'alert alert-danger';
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
						$('alert').className += ' show';
						$('alert').update('Supplies updated');
						$('btnAddshow').disabled = false;
						populate();
						disabled()
						clear();
					}
				});
			}
		})

		function clear() {
			$('txtsuType').value = '';
			$('txtitName').value = '';
			$('txtitUnit').value = '';
			/* $('rdYes').checked = false;
			$('rdNo').checked = false; */
			$('txtlocation').value = '';
			$('txtreLevel').value = '';
			$('txtacCount').value = '';
			$('dateEntered').value = '';
			$('remarks').value = '';
			$('txtSearch').value = '';
			populate();
			
		}

		function enabled() {
			$('txtitName').disabled = false;
			$('txtitUnit').disabled = false;
			$('rdYes').disabled = false;
			$('rdNo').disabled = false;
			$('txtlocation').disabled = false;
			$('txtreLevel').disabled = false;
			$('txtacCount').disabled = false;
			$('remarks').disabled = false;
			

		
		}

		function disabled() {
			$('txtitName').disabled = true;
			$('txtitUnit').disabled = true;
			$('rdYes').disabled = true;
			$('rdNo').disabled = true;
			$('txtlocation').disabled = true;
			$('txtreLevel').disabled = true;
			$('txtacCount').disabled = true;
			$('remarks').disabled = true;
			

		
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
					$('btnAddshow').disabled = true;

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