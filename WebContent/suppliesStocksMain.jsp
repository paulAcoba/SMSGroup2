<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<jsp:include page="peripherals/header.jsp"></jsp:include>
<title>Supplies Stocks Listing</title>

<link rel="stylesheet" href="css/suppliesStocks.css" type="text/css">
<%-- <jsp:include page="peripherals/header.jsp"></jsp:include> --%>
</head>
<body>

	<div id="wrapper" >
		<jsp:include page="peripherals/nav.jsp"></jsp:include>
		<!-- <input type="Button" id="btnTemp" value="Temp" /> -->

		<div id="form" style="width:80%; margin:auto;">
		<!-- <h3>Stocks</h3> -->
		<div class="panel panel-info" id="dataForm">
			<div class="panel-heading">Stocks</div>
			<div class="panel-body">
				<c:if test="${updateResult == 'failed'}">
				<label><font color="red">Updating of record failed</font></label>
				</c:if>
				<c:if test="${updateResult == 'successful'}">
				<label><font color="red">Stocks Record Updated</font></label>
				</c:if>
				<div id="form">
					<table id="formTable" style="margin:auto;">
						<tr>
							<td><label>Item Name </label></td>
							<td><select id="optionStocks" class="dropdown form-control">
										<option value=""></option>
									<c:forEach var="stocks" items="${suppliesStocks}">
										<option value="${stocks.idStock }">${stocks.itemName } ${stocks.idStock }</option>
									</c:forEach>
								</select>	
							</td>
						</tr>
						<tr>
							<td><label id="lblQty">Quantity </label></td>
							<td><input type="text" id="txtQty" class="form-control"></td>
						</tr>
						<tr>
							<td><label>Reference No. </label></td>
							<td><input type="text" id="txtRefNo" class="form-control"></td>
						</tr>
						<tr>
							<td><label id="lblDateAdded">Date Added </label></td>
							<td><input type="date" id="txtDateAdded" class="form-control"></td>
						</tr>
						<tr>
							<td><label>Purchase Date </label></td>
							<td><input type="date" id="txtDatePurchased" class="form-control"></td>
						</tr>
		
					</table>
				</div>
				<br />
				<div id="buttons" style="text-align:center;">
					<button type="Button" id="btnAddStocks" class="btn btn-success"><span class="glyphicon glyphicon-plus"></span> Add Stocks</button>
					<button type="Button" id="btnSave" class="btn btn-primary"><span class="glyphicon glyphicon-ok"></span> Insert</button>
					<button type="Button" id="btnCancel" class="btn btn-danger"> Cancel</button>
					<!-- <input type="Button" id="btnAddStocks" value="Add Stocks"><br />
					<input type="Button" id="btnSave" value="Save" /><br />
					<input type="Button" id="btnCancel" value="Cancel" /> -->
				</div>	
			</div>
		</div>
		
		<hr />
		<br />
		<div id="search">
			<label>Search </label><input type="text" id="txtSearch" class="form-control" placeholder="Item Name" onkeypress="search(event)">
		</div>
		<br />
		<div>
		<table id="stocksTable" class="blueTable" >
			<thead>
				<tr name="header">
					<th>Stock ID</th>
					<th style="display:none">Supply ID</th>
					<th>Item Name</th>
					<th>Qty</th>
					<th>Reference No.</th>
					<th>Date Added</th>
					<th>Purchase Date</th>
					<th>Last Updated By</th>
					<th>Last Update</th>
				</tr>
			</thead>
			<tbody>
				<c:forEach var="stocks" items="${suppliesStocks}">
					<tr name="row">
						<td>${stocks.idStock }</td>
						<td style="display:none">${stocks.idSupply }</td>
						<td>${stocks.itemName }</td>
						<td>${stocks.qty }</td>
						<td>${stocks.numReference }</td>
						<td><fmt:formatDate pattern="MM/dd/yyyy" value="${stocks.dateAdded }" /></td>
						<td><fmt:formatDate pattern="MM/dd/yyyy" value="${stocks.datePurchased }" /></td>
						<td>${stocks.user }</td>
						<td><fmt:formatDate pattern="MM/dd/yyyy" value="${stocks.dateUpdate }" /></td>
					</tr>
				</c:forEach>
			</tbody>
		</table>
		</div>
	</div>
	</div>
</body>
<script type="text/javascript">

	$("btnAddStocks").observe("click", addStocks);
// 	$("btnTemp").observe("click", init);
 	$("btnSave").observe("click", updateRec);
 	$("optionStocks").observe("change", updateFields);
 	
 	$("stocksTable").observe("mouseover", function(){
 		$$("#stocksTable tr[name='row']").each(function(item) {
 			item.observe("mouseover", function(){
 				item.addClassName("highlight");
			})
 			item.observe("mouseout", function(){
 				item.removeClassName("highlight");
			})
 			item.observe("click", function(){
 				$("optionStocks").value = item.down("td", 0).innerHTML;
				$("txtQty").value = item.down("td", 3).innerHTML;
				$("txtRefNo").value = item.down("td", 4).innerHTML;
				$("txtDateAdded").value = formatDate(new Date(item.down("td", 5).innerHTML));
				$("txtDatePurchased").value = formatDate(new Date(item.down("td", 6).innerHTML));
				
				removeSelected() 
				item.addClassName("selected");
			})
		})
 	});
 	
 	function removeSelected() {
 		$$("#stocksTable tr[name='row']").each(function(item) {
 			if (item.hasClassName("selected")) {
 				item.removeClassName("selected");
			}
 		})
 	};
 	
// 	function init() {
// 		new Ajax.Request("${pageContext.request.contextPath}/stocks", {
// 			method : "get",
// 			onComplete : function(response) {
// 				$("wrapper").update(response.responseText);
// 			}
// 		});
// 	}
	
	function addStocks() {
		new Ajax.Request("${pageContext.request.contextPath}/stocks", {
			method : "post",
			parameters : {
				action: "initInsert"
			},
			onComplete : function(response) {
				$("wrapper").update(response.responseText);
			}
		});
	}
	
 	function updateRec() {
 		
 		if ($F("optionStocks") != "") {
 			if (validateReqFields()) {
 				
 				$("lblQty").removeClassName("required");
 				$("lblDateAdded").removeClassName("required");
 				
 				if (validateQty()) {
 	 				new Ajax.Request(contextPath + "/stocks", {
 	 	 				method : "post",
 	 	 				parameters : {
 	 	 					action: "updateStock",
 	 	 					idStock : parseInt($F("optionStocks")),	
 	 	 					qty : parseInt($F("txtQty")),
 	 	 					refNo : $F("txtRefNo"),
 	 	 					dateAdded : $F("txtDateAdded"),
 	 	 					datePurchased : $F("txtDatePurchased"),
 	 	 					prevQty : getPrevQty($F("optionStocks")),
 	 	 					idSupply : getSupplyId($F("optionStocks"))
 	 	 				},
 	 	 				onComplete : function(response) {
 	 	 					$("wrapper").update(response.responseText);
 	 	 				}
 	 	 			});
				}
			}
		} else {
			alert("No record selected");
		}
	}
	
 	function getPrevQty(itemId) {
 		
 		var prevQty = "";
 		
 		$$("#stocksTable tr[name='row']").each(function(item) {
 			if (item.down("td", 0).innerHTML == itemId) {
 				prevQty = item.down("td", 3).innerHTML;
			}
		});
 		
 		return prevQty;
 	}
 	
 	function getSupplyId(itemId) {
 		
 		var supplyId = "";
 		
 		$$("#stocksTable tr[name='row']").each(function(item) {
 			if (item.down("td", 0).innerHTML == itemId) {
 				supplyId = item.down("td", 1).innerHTML;
			}
		});
 		
 		return supplyId;
 	}
 	
 	function search(event) {
 		
 		if (event.keyCode == 13) {
 			new Ajax.Request("${pageContext.request.contextPath}/stocks", {
 				method : "post",
 				parameters : {
 					action: "search",
 					itemName: $F("txtSearch").toUpperCase()
 					//itemName : toUpperCase($F("txtSearch"))
 				},
 				onComplete : function(response) {
 					$("wrapper").update(response.responseText);
 				}
 			});
		}
 	}
 	

	function updateFields() {

		if ($F("optionStocks") != "") {

			$$("#stocksTable tr[name='row']")
					.each(
							function(item) {
								if (item.down("td", 0).innerHTML == $F("optionStocks")) {
									$("txtQty").value = item.down("td", 3).innerHTML;
									$("txtRefNo").value = item.down("td", 4).innerHTML;
									$("txtDateAdded").value = formatDate(new Date(item.down("td", 5).innerHTML));
									$("txtDatePurchased").value = formatDate(new Date(item.down("td", 6).innerHTML));
								}
							});

		} else {
			$("txtQty").value = "";
			$("txtRefNo").value = "";
			$("txtDateAdded").value = "";
			$("txtDatePurchased").value = "";
		}
	}

	function formatDate(date) {
		var d = new Date(date),
			month = '' + (d.getMonth() + 1),
			day = '' + d.getDate(), 
			year = d.getFullYear();

		if (month.length < 2)
			month = '0' + month;
		if (day.length < 2)
			day = '0' + day;

		return [ year, month, day ].join('-');
	}
	
	function validateQty() {
		
		var validateQty = true;
		
		if (!isNaN(parseInt($("txtQty").value))) {
			if (parseInt($("txtQty").value) < 1) {
				alert("Quantity should be greater than 0");
				validateQty = false;
			}
		} else {
			alert("Invalid Quantity Value");
			validateQty = false;
		};
		
		return validateQty;
	}

	function validateReqFields() {
		
		var validateFields = true;
		var displayMsg = false;
	 
			if ($("txtQty").value == "") {
				$("lblQty").addClassName("required");
				displayMsg = true;
				validateFields = false;
			}else {
				$("lblQty").removeClassName("required");
			}
			
			if ($("txtDateAdded").value == "") {
				$("lblDateAdded").addClassName("required");
				displayMsg = true;
				validateFields = false;
			}else {
				$("lblDateAdded").removeClassName("required");
			}
		
			if (displayMsg) {
				alert("Please fill up all required fields");
			}
			
		return validateFields;
	}
</script>
</html>