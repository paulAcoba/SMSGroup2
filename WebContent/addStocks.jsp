<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
	pageEncoding="ISO-8859-1"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
<title>Add Stocks</title>
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
				<div id="form">
					<table>
						<tr>
							<td><label id="lblItemName">Item Name </label></td>
							<td><select id="optionSupplies" class="form-control" style="width: 210px;">
									<option value=""></option>
									<c:forEach var="supplies" items="${supplies}">
										<option value="${supplies.idSupply}">${supplies.itemName }</option>
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
							<td><input type="date" id="txtDateAdded" class="form-control"></td>
						</tr>
						<tr>
							<td><label>Purchase Date </label></td>
							<td><input type="date" id="txtDatePurchased" class="form-control"></td>
						</tr>

					</table>
				</div>
				<br />
				<br />
				<div id="buttons">
					<button type="Button" id="btnSave" class="btn btn-primary" style="width: 100px">
						<span class="glyphicon glyphicon-ok"></span> Save 
					</button>
					<button type="button" id="btnCancel" class="btn btn-danger" style="width: 100px">Cancel</button>
				</div>
			</div>
		</div>
	</div>
</body>
<script type="text/javascript">

	$("btnSave").observe("click", addStocks);
	$("btnCancel").observe("click", returnHome);
	
	if("${insertResult}" == "successful") {
		$("modalP").update("Stock successfully Added.");
		$("modal-content").writeAttribute("style", "background-color:#ccffcc");
		$("myModal").writeAttribute("style", "display:block");
	}
	
	if("${insertResult}" == "failed") {
		$("modalP").update("Transaction Failed");
		$("modal-content").writeAttribute("style", "background-color:#ffcccc");
		$("myModal").writeAttribute("style", "display:block");
	}
	
	function addStocks() {
		
		if (validateReqFields()) {
			
			$("lblItemName").removeClassName("required");
			$("lblQty").removeClassName("required");
			$("lblDateAdded").removeClassName("required");
			
			if (validateQty()) {
				new Ajax.Request(contextPath + "/stocks", {
					method : "post",
					parameters : { action : "insertStock",
						idSupply : parseInt($F("optionSupplies")),
						qty : parseInt($F("txtQty")),
						refNo : $F("txtRefNo"),
						dateAdded : $F("txtDateAdded"),
						datePurchased : $F("txtDatePurchased"),
						user : "TEST"
					},
					onComplete : function(response) {
						$("wrapper").update(response.responseText);
					}
				});
			}
		}
	}
	
	function returnHome() {
		new Ajax.Request("${pageContext.request.contextPath}/stocks", {
			method : "get",
			onComplete : function(response) {
				$("wrapper").update(response.responseText);
			}
		});
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
			
			if ($("optionSupplies").value == "") {
				$("lblItemName").addClassName("required");
				displayMsg = true;
				validateFields = false;
			}else {
				$("lblItemName").removeClassName("required");
			}
			
			if (displayMsg) {
				$("modalP").update("Please fill up all required fields");
				$("modal-content").writeAttribute("style", "background-color:#ffcccc");
				$("myModal").writeAttribute("style", "display:block");
			}
			
		return validateFields;
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
	
	$("modalClose").observe("click", function(){
		myModal.writeAttribute("style", "display:none");
	});
</script>
</html>