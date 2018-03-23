<div id="dataForm">
	<table id="dataFormTable">
		<tr>	
			<td><label>Item Name</label></td>
			<td><select id="selItems">
				<%-- <c:forEach var="itList" items="${itemList}">
					<option value="${itList.supplyId}"><c:out value="${itList.itemName}"></c:out></option>
				</c:forEach> --%>
				<script>
					sels();
				</script>
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
				<script>
					depts();
				</script>
			</select></td>
		</tr>
		<tr>	
			<td><label>Issue Date</label></td>
			<td><input type="date" name="txtIssueDate" id="txtIssueDate"></td>
		</tr>
		<tr>	
			<td colspan="2"><input type="button" name="btnAdd" id="btnAdd" value="Add New">
			<input type="button" name="btnCancel2" id="btnCancel2" value="Cancel"></td>
		</tr>
	</table>
</div>

<script>
//sels();
//alert(9);
$('btnCancel2').observe("click", function(){
	 new Ajax.Request(contextPath + "/issuedSupply",{
			method: "POST",
			parameters:{
				action: "cancel"
			},
			onComplete : function(response){
				$('wrapper').update(response.responseText);
				refresh();
			}
		});
}); 

//alert(10);
$('btnAdd').observe("click",function(){
	new Ajax.Request(contextPath + "/issuedSupply",{
		method: "POST",
		parameters:{
			action: "addData",
			supplyId: $F('selItems'),
			issueDate: $F('txtIssueDate'),
			requestor: $F('txtRequestedBy'),
			quantity: $F('txtQuantity'),
			deptId: $F('selDept')
		},
		onComplete : function(response){
			$('wrapper').update(response.responseText);
			alert("Data Added");
			//alert(response.responseText);
			refresh();
		}
	});
});
</script>