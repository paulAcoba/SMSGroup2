<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
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
					<c:out value="${allIssuedSupply}"></c:out>
				</table>
			</div>
		</fieldset>
	</div>
</body>
</html>
<script>
try{
	function refresh(){
		new Ajax.Request(contextPath + "/issuedSupply",{
			method: "POST",
			parameter:{
				action: "refresh"
			},
			onComplete : function(response){
				$('dataTable').update({bottom:response.responseText});
			}
		});
	}
	
	$('btnAdd').observe("click",function(){
		new Ajax.Request(contextPath + "/issuedSupply",{
			method: "POST",
			parameter:{
				action: "addData",
				supplyId: $F('selItems'),
				issueDate: $F('txtIssueDate'),
				requestor: $F('txtRequestedBy'),
				quantity: $F('txtQuantity'),
				deptId: $F('selDept')
			},
			onComplete : function(response){
				//$('dataTable').update(response.responseText);
				alert("Data Added");
				refresh();
			}
		});
	});
	
	function updateIssue(){
		new Ajax.Request(contextPath + "/issuedSupply",{
			method: "POST",
			parameter:{
				action: "updateData",
				supplyId: $F('selItems'),
				issueDate: $F('txtIssueDate'),
				requestor: $F('txtRequestedBy'),
				quantity: $F('txtQuantity'),
				deptId: $F('selDept')
			},
			onComplete : function(response){
				//$('dataTable').update(response.responseText);
				alert("Data Added");
				refresh();
				//clear();
			}
		});
	}
	
	$('btnSave').observe("click", updateIssue);
	
	function clear(){
		$('selItems').value = '1';
		$('txtIssueDate').value = '';
		$('txtRequestedBy').value = '';
		$('txtQuantity').value = '';
		$('selDept').value = '1';
	}
	
	$('btnCancel').observe("click", refresh);
}catch(e){
	alert("home.jsp "+e);
}
	
	
	
</script>