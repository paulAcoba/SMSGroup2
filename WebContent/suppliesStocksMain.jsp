<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
	pageEncoding="ISO-8859-1"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
<title>Supplies Stocks Listing</title>
<jsp:include page="peripherals/header.jsp"></jsp:include>
<script src='js/prototype.js'></script>
<script> var contextPath = "${pageContext.request.contextPath}";</script>
<link rel="stylesheet" href="css/suppliesStocks.css" type="text/css">
</head>
<body>
	<div id="wrapper">
		<jsp:include page="peripherals/nav.jsp"></jsp:include>
		<div id="myModal" class="modal">
			<div class="modal-content" id="modal-content">
				<span id="modalClose" class="close">&times;</span>
				<p id="modalP"></p>
			</div>
		</div>
		<div class="panel panel-info" id="userDataForm">
			<div class="panel-heading">Stocks</div>
			<div class="panel-body">
				<form>
					<div id="form">
						<table>
							<tr>
								<td><label>Item Name </label></td>
								<td><select id="optionStocks" class="form-control"
									style="width: 210px;">
										<option value=""></option>
										<c:forEach var="stocks" items="${suppliesStocks}">
											<option value="${stocks.idStock }">${stocks.itemName }
												${stocks.idStock }</option>
										</c:forEach>
								</select></td>
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
								<td><input type="date" id="txtDateAdded"
									class="form-control"></td>
							</tr>
							<tr>
								<td><label>Purchase Date </label></td>
								<td><input type="date" id="txtDatePurchased"
									class="form-control"></td>
							</tr>

						</table>
					</div>
					<br />
					<br />
					<div id="buttons">
						<table>
							<tr>
								<td>
									<Button type="Button" id="btnAddStocks" class="btn btn-success"
										style="width: 100px">
										<span class="glyphicon glyphicon-plus"></span> Add New
									</Button>
								</td>
								<td>
									<button type="Button" id="btnSave" class="btn btn-primary"
										style="width: 100px">
										<span class="glyphicon glyphicon-ok"></span> Save
									</button>
								</td>
								<td>
									<button type="button" id="btnCancel" class="btn btn-danger"
										style="width: 100px">Cancel</button>
								</td>
							</tr>
						</table>
					</div>
				</form>
			</div>
		</div>
		<br />
		<div id="search">
			<table align="center">
			<tr>
				<td><label>Search</label></td>
				<td><input type="text" id="txtSearch" class="form-control" placeholder="Item Name" onkeypress="search(event)"></td>
			</tr>
			</table>
			<br />
			<table id="stocksTable" class="blueTable" align="center">
				<thead>
					<tr name="header">
						<th>Stock ID</th>
						<th style="display: none">Supply ID</th>
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
							<td style="display: none">${stocks.idSupply }</td>
							<td>${stocks.itemName }</td>
							<td>${stocks.qty }</td>
							<td>${stocks.numReference }</td>
							<td><fmt:formatDate pattern="MM/dd/yyyy"
									value="${stocks.dateAdded }" /></td>
							<td><fmt:formatDate pattern="MM/dd/yyyy"
									value="${stocks.datePurchased }" /></td>
							<td>${stocks.user }</td>
							<td><fmt:formatDate pattern="MM/dd/yyyy"
									value="${stocks.dateUpdate }" /></td>
						</tr>
					</c:forEach>
				</tbody>
			</table>
		</div>
	</div>
</body>
<script type="text/javascript">
	$("btnAddStocks").observe("click", addStocks);
	$("btnSave").observe("click", updateRec);
	$("optionStocks").observe("change", updateFields);
	$("btnCancel").observe("click", clearFields);
	
	if("${updateResult}" == "successful") {
		$("modalP").update("Stock successfully updated.");
		$("modal-content").writeAttribute("style", "background-color:#ccffcc");
		$("myModal").writeAttribute("style", "display:block");
	}
	
	if("${updateResult}" == "failed") {
		$("modalP").update("Transaction Failed.");
		$("modal-content").writeAttribute("style", "background-color:#ffcccc");
		$("myModal").writeAttribute("style", "display:block");
	}
	
	$("stocksTable")
			.observe(
					"mouseover",
					function() {
						$$("#stocksTable tr[name='row']")
								.each(
										function(item) {
											item
													.observe(
															"mouseover",
															function() {
																item
																		.addClassName("highlight");
															})
											item
													.observe(
															"mouseout",
															function() {
																item
																		.removeClassName("highlight");
															})
											item
													.observe(
															"click",
															function() {
																$("optionStocks").value = item
																		.down(
																				"td",
																				0).innerHTML;
																$("txtQty").value = item
																		.down(
																				"td",
																				3).innerHTML;
																$("txtRefNo").value = item
																		.down(
																				"td",
																				4).innerHTML;
																$("txtDateAdded").value = formatDate(new Date(
																		item
																				.down(
																						"td",
																						5).innerHTML));
																$("txtDatePurchased").value = formatDate(new Date(
																		item
																				.down(
																						"td",
																						6).innerHTML));

																removeSelected()
																item
																		.addClassName("selected");
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

	function addStocks() {
		new Ajax.Request("${pageContext.request.contextPath}/stocks", {
			method : "post",
			parameters : {
				action : "initInsert"
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
							action : "updateStock",
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
			$("modalP").update("No record selected");
			$("modal-content").writeAttribute("style", "background-color:#ffcccc");
			$("myModal").writeAttribute("style", "display:block");
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
					action : "search",
					itemName : $F("txtSearch").toUpperCase()
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
									$("txtDateAdded").value = formatDate(new Date(
											item.down("td", 5).innerHTML));
									$("txtDatePurchased").value = formatDate(new Date(
											item.down("td", 6).innerHTML));
									
									removeSelected()
									item.addClassName("selected");
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
		var d = new Date(date), month = '' + (d.getMonth() + 1), day = ''
				+ d.getDate(), year = d.getFullYear();

		if (month.length < 2)
			month = '0' + month;
		if (day.length < 2)
			day = '0' + day;

		return [ year, month, day ].join('-');
	}

	function validateQty() {

		var validateQty = true;

		if (!isNaN(parseInt($("txtQty").value))) {
			if ($("txtQty").value.indexOf('.') != 1) {
				if (parseInt($("txtQty").value) < 1) {
					$("modalP").update("Quantity should be greater than 0");
					$("modal-content").writeAttribute("style", "background-color:#ffcccc");
					$("myModal").writeAttribute("style", "display:block");
					validateQty = false;
				}
			} else {
				$("modalP").update("Invalid Quantity Value");
				$("modal-content").writeAttribute("style", "background-color:#ffcccc");
				$("myModal").writeAttribute("style", "display:block");
				validateQty = false;
			}
		} else {
			$("modalP").update("Invalid Quantity Value");
			$("modal-content").writeAttribute("style", "background-color:#ffcccc");
			$("myModal").writeAttribute("style", "display:block");
			validateQty = false;
		}
		;

		return validateQty;
	}

	function validateReqFields() {

		var validateFields = true;
		var displayMsg = false;

		if ($("txtQty").value == "") {
			$("lblQty").addClassName("required");
			displayMsg = true;
			validateFields = false;
		} else {
			$("lblQty").removeClassName("required");
		}

		if ($("txtDateAdded").value == "") {
			$("lblDateAdded").addClassName("required");
			displayMsg = true;
			validateFields = false;
		} else {
			$("lblDateAdded").removeClassName("required");
		}

		if (displayMsg) {
			$("modalP").update("Please fill up all required fields");
			$("modal-content").writeAttribute("style", "background-color:#ffcccc");
			$("myModal").writeAttribute("style", "display:block");
		}

		return validateFields;
	}
	
	function clearFields() {
		$("optionStocks").value = "";
		$("txtQty").value = "";
		$("txtRefNo").value = "";
		$("txtDateAdded").value = "";
		$("txtDatePurchased").value = "";
		removeSelected()
	}
	
	$("modalClose").observe("click", function(){
		myModal.writeAttribute("style", "display:none");
	});
	
</script>
</html>