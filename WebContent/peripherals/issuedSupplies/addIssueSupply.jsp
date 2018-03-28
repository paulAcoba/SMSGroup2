

<div id="dataFormAdd"  class="panel panel-info">
<div class="panel-heading">Request Supply</div>
<div class="panel-body">
	<div class="alert alert-danger" id="alerts" hidden>${message}</div>
	<table id="dataFormTable">
		<tr>	
			<td><label>Item Name</label></td>
			<td><select id="selItems" class="form-control">
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
			<td><input type="text" name="txtQuantity" id="txtQuantity" class="form-control"></td>
		</tr>
		<tr>	
			<td><label>Requested By</label></td>
			<td><input type="text" name="txtRequestedBy" id="txtRequestedBy" class="form-control"></td>
		</tr>
		<tr>	
			<td><label>Department Name</label></td>
			<td><select id="selDept" class="form-control">
				<script>
					depts();
				</script>
			</select></td>
		</tr>
		<tr>	
			<td><label>Issue Date</label></td>
			<td><input type="date" name="txtIssueDate" id="txtIssueDate" class="form-control" required></td>
		</tr>
		<tr class="buttons">	
			<td colspan="2">
			
							<button type="button" name="btnAdd" id="btnAdd" class="btn btn-primary"><span class="glyphicon glyphicon-ok"></span> Add</button>
							<button type="button" name="btnCancel2" id="btnCancel2" class="btn btn-danger"><span class="glyphicon glyphicon-remove"></span> Cancel</button>
			<!-- <input type="button" name="btnAdd" id="btnAdd" class="btn btn-success" value="Add New">
			<input type="button" name="btnCancel2" id="btnCancel2" class="btn btn-danger" value="Cancel"> --></td>
		</tr>
	</table>
</div>
</div>

<script>
//sels();

sels();
depts();
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
	if(isNaN($F('txtQuantity')) ){
		$('alerts').className += ' show';
		$('alerts').update("<strong>Warning!</strong> Value of Quantity must be a number");
	}else if(!$F('txtQuantity') || $F('txtQuantity').lenght <=0 || $F('txtRequestedBy') == ''){
		$('alerts').className += ' show';
		$('alerts').update("<strong>Warning!</strong> Please fill all the fields");
	}else{
		$('alerts').className = 'alert alert-danger';
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
				$('issueSupplies').update(response.responseText);
				
			}
		});
	}
});
</script>