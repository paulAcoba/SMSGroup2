<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
	pageEncoding="ISO-8859-1"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
<title>Add Stocks</title>
<script src='js/prototype.js'></script>
<script> var contextPath = "${pageContext.request.contextPath}";</script>
<link rel="stylesheet" href="css/suppliesStocks.css" type="text/css">
</head>
<body>
	<div id="wrapper">
		<h3>Stocks</h3>
		<div id="form">
		<c:if test="${insertResult == 'failed'}">
		<label><font color="red">transaction failed</font></label>
		</c:if>
		<c:if test="${insertResult == 'successful'}">
		<label><font color="red">Reordering of supply is successful</font></label>
		</c:if>
			<table>
				<tr>
					<td><label id="lblItemName">Item Name </label></td>
					<td><select id="optionSupplies" class="dropdown">
								<option value=""></option>
							<c:forEach var="supplies" items="${supplies}">
								<option value="${supplies.idSupply}">${supplies.itemName } ${supplies.idSupply}</option>
							</c:forEach>
						</select>
					</td>
				</tr>
				<tr>
					<td><label id="lblQty">Quantity </label></td>
					<td><input type="text" id="txtQty"></td>
				</tr>
				<tr>
					<td><label>Reference No. </label></td>
					<td><input type="text" id="txtRefNo"></td>
				</tr>
				<tr>
					<td><label id="lblDateAdded">Date Added </label></td>
					<td><input type="date" id="txtDateAdded"></td>
				</tr>
				<tr>
					<td><label>Purchase Date </label></td>
					<td><input type="date" id="txtDatePurchased"></td>
				</tr>

			</table>
		</div>
		<br />
		<div id="buttons">
			<input type="Button" id="btnSave" value="Save">
			<input type="Button" id="btnCancel" value="Cancel">
		</div>
	</div>
</body>
<script type="text/javascript">

	$("btnSave").observe("click", addStocks);
	$("btnCancel").observe("click", returnHome);
	
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
		
		if ($("optionSupplies").value == "" || $("txtQty").value == "" || $("txtDateAdded").value == "") {
			alert("Please fill up all required fields");
			validateFields = false;
			
			$("lblItemName").addClassName("required");
			$("lblQty").addClassName("required");
			$("lblDateAdded").addClassName("required");
		}
		
		return validateFields;
	}
	
	function validateQty() {
		
		var validateQty = true;
		
		if (!isNaN(parseInt($("txtQty").value))) {
			if (parseInt($("txtQty").value) < 1) {
				alert("Quantity should be greater than 0");
				validateQty = false;
			}
		} else {
			alert("Only Numerical Values are valid for this field");
			validateQty = false;
		};
		
		return validateQty;
	}
</script>
</html>