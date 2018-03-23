<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"  %>
<jsp:include page="../peripherals/header.jsp"></jsp:include>
<title>Issue Supplies</title>
</head>
<body>
	<div id="wrapper">
		<jsp:include page="../peripherals/nav.jsp"></jsp:include>
		<fieldset title="Issue Supplies" id="issueSupplies">
			<div id="dataForm">
				<table id="dataFormTable">
					<tr>	
						<td><label>Item Name</label></td>
						<td><select id="selItems">
							<%-- <c:forEach var="itList" items="${itemList}">
								<option value="${itList.supplyId}"><c:out value="${itList.itemName}"></c:out></option>
							</c:forEach> --%>
						</select></td>
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
						<td colspan="2"><input type="button" name="btnIssueRequest" id="btnIssueRequest" value="Issue Request">
						<input type="button" name="btnSave" id="btnSave" value="Save">
						<input type="button" name="btnCancel" id="btnCancel" value="Cancel"></td>
					</tr>
				</table>
			</div>
			<div id="issuedSupplyTable" class="tableDiv">
				<label>Search: </label>
				<input type="text" name="txtSearch" id="txtSearch"><br/>
				<table id="dataTable" border="1">
					
					<c:forEach var="isup" items="${issuedSuppliesList}">
						<tr id="${isup.issueId}">
							<td><c:out value="${isup.issueId}"></c:out></td>
							<td><c:out value="${isup.supplyId}"></c:out></td>
							<td><c:out value="${isup.quantity}"></c:out></td>
							<td><c:out value="${isup.requestor}"></c:out></td>
							<td><c:out value="${isup.deptId}"></c:out></td>
							<td><fmt:formatDate type="date" pattern="dd-MMM-yyyy" value="${isup.issueDate}"></fmt:formatDate></td>
							<td><c:out value="${isup.lastUser}"></c:out></td>
							<td><fmt:formatDate type="date" pattern="dd-MMM-yyyy" value="${isup.lastUpdate}"></fmt:formatDate></td>
						</tr>
					</c:forEach>
				</table>
			</div>
		</fieldset>
	</div>
</body>
</html>
<script>
try{
	//alert(1);
	function refresh(){
		new Ajax.Request(contextPath + "/issuedSupply",{
			method: "POST",
			parameters:{
				action: "refresh"
			},
			onComplete : function(response){
				$('dataTable').update(response.responseText);
				sels();
			}
		});
	}

	//refresh();
	//alert(2);
	function sels(){
		new Ajax.Request(contextPath + "/issuedSupply",{
			method: "POST",
			parameters:{
				action: "sels"
			},
			onComplete : function(response){
				$('selItems').update(response.responseText);
			}
		});
	}

	//alert(3);
	$('btnIssue').observe("click",function(){
		refresh();
	});

	//alert(4);
	$('btnIssueRequest').observe("click",function(){
		new Ajax.Request(contextPath + "/issuedSupply",{
			method: "POST",
			parameters:{
				action: "issue"
			},
			onComplete : function(response){
				$('issueSupplies').update(response.responseText);
				//sels();
			}
		});
	});

	//alert(5);
	function updateIssue(){
		new Ajax.Request(contextPath + "/issuedSupply",{
			method: "POST",
			parameters:{
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

	//alert(6);
	$('btnSave').observe("click", updateIssue);

	//alert(7);
	function clear(){
		$('selItems').value = '1';
		$('txtIssueDate').value = '';
		$('txtRequestedBy').value = '';
		$('txtQuantity').value = '';
		$('selDept').value = '1';
	}

	//alert(8);
	var table = $('dataTable');
	
	for(var i = 1; i<table.rows.length;i++){
		table.rows[i].onclick = function(){
			alert(this.cells[3].innerHTML);
		}
	}
	
	
}catch(e){
	alert("issuedsupply.jsp "+e);
	console.log(e);
}
	
	
	
</script>