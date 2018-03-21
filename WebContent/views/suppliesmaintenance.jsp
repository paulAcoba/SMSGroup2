
<jsp:include page="../peripherals/header.jsp"></jsp:include>
<link rel="stylesheet" type="text/css" href="../css/suppliesmaintenance.css">
<title>Supplies Maintenance</title>
</head>
<body>
	<div id="wrapper">
		<jsp:include page="../peripherals/nav.jsp"></jsp:include>
		<fieldset title="Supplies Maintenance">

			<div id="dataForm">
				<table id="dataFormTable">
					<tr>
						<td><label>Supply Type: </label></td>
						<td><input type="text" id="txtsuType"></td>
					</tr>
					<tr>
						<td><label>Item Name:</label></td>
						<td><input type="text" id="txtitName"></td>
					</tr>
					<tr>
						<td><label>Item Unit:</label></td>
						<td><input type="text" id="txtitUnit"></td>
					</tr>
					<tr>
						<td><label>Obsolete Tag:</label></td>
						<td><form>
								<input type="radio" name="obselete" value="Yes" id="rdYes">Yes
								<input type="radio" name="obselete" value="No" id="rdNo">No
							</form></td>
					</tr>
					<tr>
						<td><label>Location:</label></td>
						<td><input type="text" id="txtlocation"></td>
					</tr>
					<tr>
						<td><label>Entered Date:</label></td>
						<td><input type="date" name="txtDate" id="txtDate"></td>
					</tr>

					<tr >
						<td><label>Reorder Level:</label></td>
						<td><input type="text" name="txtreLevel"> <label>Actual Count: </label><input 
							type="text" name="txtacCount"  ></td>

					</tr>

					<tr>
						<form>
							<td><label>Description :</label></td>
							<td><textarea rows="5" cols="30" name="description">
							</textarea></td>
						</form>


					</tr>
					<tr>
						<td colspan="2"><input type="button" name="btnAdd"
							id="btnAdd" value="Add New"> <input type="button"
							name="btnSave" id="btnSave" value="Save"> <input
							type="button" name="btnCancel" id="btnCancel" value="Cancel"></td>
					</tr>
				</table>
			</div>
			<div id="issuedSupplyTable" class="tableDiv">
				<label>Search: </label> <input type="text" name="txtSearch"
					id="txtSearch"><br />
				<table id="dataTable">
					<tr id="dataTableHeader">
						<th>Supply ID</th>
						<th>Supply Type</th>
						<th>Item Name</th>
						<th>Item Unit</th>
						<th>Obsolete Tag</th>
						<th>Location</th>
						<th>Reoder Level</th>
						<th>Actual Count</th>
						<th>Remarks</th>
						<th>Entry Date</th>
						<th>Last Updated By</th>
						<th>Last Update</th>
					</tr>
				</table>
			</div>
		</fieldset>
	</div>
</body>
</html>
<script>

</script>