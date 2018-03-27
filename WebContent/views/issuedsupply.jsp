<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<jsp:include page="../peripherals/header.jsp"></jsp:include>
<title>Issue Supplies</title>
<script>
	window.onload = function(){
		refresh();
	}
</script>
</head>
<body>
	<div id="wrapper">
		<jsp:include page="../peripherals/nav.jsp"></jsp:include>
	<div class="container">
		<fieldset title="Issue Supplies" id="issueSupplies">
			<div id="dataForm" class="panel panel-info">
				<div class="panel-heading">Supply Issuance</div>
				<div class="panel-body">
				<div class="alert alert-danger" id="alert">${message}</div>
				<table id="dataFormTable" style="margin:auto;">
					<tr>
						<td><label id="issueId"></label></td>
						<td><label id="txtIssueId"></label></td>
					</tr>
					<tr>
						<td><input type="hidden" id="txtOldItem" name="txtOldItem"/></td>
						<td><input type="hidden" id="txtOldQuantity" name="txtOldQuantity"/></td>
					</tr>
					<tr>
						<td><label>Item Name </label></td>
						<td><select id="selItems" class="form-control">
								<%-- <c:forEach var="itList" items="${itemList}">
								<option value="${itList.supplyId}"><c:out value="${itList.itemName}"></c:out></option>
							</c:forEach> --%>
						</select></td>
					</tr>
					<tr>
						<td><label>Quantity </label></td>
						<td><input type="text" name="txtQuantity" id="txtQuantity" class="form-control"></td>
					</tr>
					<tr>
						<td><label>Requested By </label></td>
						<td><input type="text" name="txtRequestedBy"
							id="txtRequestedBy" class="form-control"></td>
					</tr>
					<tr>
						<td><label>Department Name </label></td>
						<td><select id="selDept" class="form-control">
						</select></td>
					</tr>
					<tr>
						<td><label>Issue Date </label></td>
						<td><input type="date" name="txtIssueDate" id="txtIssueDate" class="form-control" required></td>
					</tr>
					<tr class="buttons">
						<td colspan="2"><input type="button" name="btnIssueRequest"
							id="btnIssueRequest" class="btn btn-success" value="Issue Request" data-toggle="modal" data-target="#dataFormAdd"> <input
							type="button" name="btnSave" id="btnSave" class="btn btn-danger" value="Save"> <input
							type="button" name="btnCancel" id="btnCancel" class="btn btn-info" value="Cancel"></td>
					</tr>
				</table>
				</div>
			</div>
			<div id="issuedSupplyTable" class="tableDiv">
				<label>Search: </label> <input type="text" name="txtSearch"
					id="txtSearch" class="form-control" placeholder="Issue ID"><br />
				<table id="dataTable" class="table table-hover">
					<c:forEach var="isup" items="${issuedSuppliesList}">
						<tr id="${isup.issueId}">
							<td><c:out value="${isup.issueId}"></c:out></td>
							<td><c:out value="${isup.supplyId}"></c:out></td>
							<td><c:out value="${isup.quantity}"></c:out></td>
							<td><c:out value="${isup.requestor}"></c:out></td>
							<td><c:out value="${isup.deptId}"></c:out></td>
							<td><fmt:formatDate type="date" pattern="dd-MMM-yyyy"
									value="${isup.issueDate}"></fmt:formatDate></td>
							<td><c:out value="${isup.lastUser}"></c:out></td>
							<td><fmt:formatDate type="date" pattern="dd-MMM-yyyy"
									value="${isup.lastUpdate}"></fmt:formatDate></td>
						</tr>
					</c:forEach>
				</table>
			</div>
			
		</fieldset>
	</div>
	</div>
</body>
</html>
<jsp:include page="../peripherals/footer.jsp"></jsp:include>
<script>
	try {
		
		function sels() {
			new Ajax.Request(contextPath + "/issuedSupply", {
				method : "POST",
				parameters : {
					action : "sels"
				},
				onComplete : function(response) {
					$('selItems').update(response.responseText);
				}
			});
		}

		function depts() {
			new Ajax.Request(contextPath + "/issuedSupply", {
				method : "POST",
				parameters : {
					action : "depts"
				},
				onComplete : function(response) {
					$('selDept').update(response.responseText);
				}
			});
		}

		function clickRow(){
			var table = $('dataTable');

			for (var i = 1; i < table.rows.length; i++) {
				table.rows[i].onclick = function() {
					//alert(this.cells[1].innerHTML);
					var selID = this.cells[1].children[0].value;
					var deptID = this.cells[4].children[0].value;

					$('issueId').update("Issue ID ");
					$('txtIssueId').update(this.cells[0].innerText);
					$('selItems').value = selID;
					$('txtOldItem').value = selID;
					$('txtQuantity').value = this.cells[2].innerText;
					$('txtOldQuantity').value = this.cells[2].innerText;
					$('txtRequestedBy').value = this.cells[3].innerText;
					$('selDept').value = deptID;
					$('txtIssueDate').value = this.cells[5].children[0].value;
				}
			}
		}

		function refresh() {
			new Ajax.Request(contextPath + "/issuedSupply",{
				method : "POST",
				parameters : {
					action : "refresh"
				},
				onComplete : function(response) {
					$('dataTable').update(response.responseText);
					sels();
					depts();
					clear();

					clickRow();
				}
			});
		}
		
		 $('btnIssueRequest').observe("click", function() {
			 new Ajax.Request(contextPath + "/issuedSupply", {
				method : "POST",
				parameters : {
					action : "issue"
				},
				onComplete : function(response) {
					$('issueSupplies').update(response.responseText);
				}
			}); 
		});

		//alert(5);
		$('btnSave').observe("click", function() {
			if(isNaN($F('txtQuantity'))){
				$('alert').update("Value of Quantity must be a number");
			}else if(!$F('txtQuantity') || $F('txtQuantity').lenght <=0){
				$('alert').update("Quantity must have value.");
			}else{
				new Ajax.Request(contextPath + "/issuedSupply", {
					method : "POST",
					parameters : {
						action : "updateData",
						issueId : $('txtIssueId').innerHTML,
						supplyId : $F('selItems'),
						oldItem : $F('txtOldItem'),
						issueDate : $F('txtIssueDate'),
						requestor : $F('txtRequestedBy'),
						oldQuantity : $F('txtOldQuantity'),
						quantity : $F('txtQuantity'),
						deptId : $F('selDept')
					},
					onComplete : function(response) {
						alert("Data Updated");
						refresh();
					}
				});
			}
			
		});

		$('btnCancel').observe("click", function(){
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
		
		//alert(7);
		function clear() {
			$('txtIssueDate').value = '';
			$('txtRequestedBy').value = '';
			$('txtQuantity').value = '';
		}

		$('txtSearch').observe("keyup", function() {
			refresh("search");
			new Ajax.Request(contextPath + "/issuedSupply", {
				method : "POST",
				parameters : {
					action : "search",
					searching : $F('txtSearch')
				},
				onComplete : function(response) {
					$('dataTable').update(response.responseText);
					//alert("search");
					//refresh("search");
					//clear();
					clickRow();
				}
			});
		});

	} catch (e) {
		alert("issuedsupply.jsp " + e);
		console.log(e);
	}
</script>