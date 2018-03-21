<jsp:include page="../peripherals/header.jsp"></jsp:include>
<title>Issue Supplies</title>
</head>
<body>
	<div id="wrapper">
		<jsp:include page="../peripherals/nav.jsp"></jsp:include>
		<fieldset title="Issue Supplies">
			<div id="dataForm">
				<table id="dataFormTable">
					<tr>	
						<td><label>Item Name</label></td>
						<td><select id="selItems"></select></td>
					</tr>
					<tr>	
						<td><label>Quantity</label></td>
						<td><input type="text" name="txtQuantity" id="txtQuantity"></td>
					</tr>
					<tr>	
						<td><label>Requested By</label></td>
						<td><input type="text" name="txtRequestedBy" id="txtRequestedBy"></td>
					</tr>
					<tr>	
						<td><label>Department Name</label></td>
						<td><select id="selDept">
							<option value="1">Sales</option>
							<option value="2">IT</option>
							<option value="3">Finance</option>
						</select></td>
					</tr>
					<tr>	
						<td><label>Issue Date</label></td>
						<td><input type="date" name="txtIssueDate" id="txtIssueDate"></td>
					</tr>
					<tr>	
						<td colspan="2"><input type="button" name="btnAdd" id="btnAdd" value="Add New">
						<input type="button" name="btnSave" id="btnSave" value="Save">
						<input type="button" name="btnCancel" id="btnCancel" value="Cancel"></td>
					</tr>
				</table>
			</div>
			<div id="issuedSupplyTable" class="tableDiv">
				<label>Search: </label>
				<input type="text" name="txtSearch" id="txtSearch"><br/>
				<table id="dataTable">
					<tr id="dataTableHeader">
						<th>Issue ID</th>
						<th>Item Name</th>
						<th>Qty</th>
						<th>Requested By</th>
						<th>Department Name</th>
						<th>Issue Date</th>
						<th>Last Updated By</th>
						<th>Last Update</th>
					</tr>
				</table>
			</div>
		</fieldset>
	</div>
</body>
</html>