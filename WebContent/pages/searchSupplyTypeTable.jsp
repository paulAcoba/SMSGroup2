<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
	pageEncoding="ISO-8859-1"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
<title>Insert title here</title>
<style type="text/css">
#supplyTypeTable {
	border-collapse: collapse;
	border: 1px solid black;
	width: 700px;
	font: 12px Arial;
	border-radius: 0px;
	box-shadow: 10px 10px 5px grey;
	text-align: center;
}

#sId, #sTn, #sD, #sLu, #sLud, .th1, .records {
	border: 1px solid black;
}

.records:hover {
	background-color: #d5d3d2;
	color: #4798f2;
}
</style>
</head>
<body>
	<table border="1" id="supplyTypeTable">
		<tr>
			<th class="th1">Supply Type ID</th>
			<th class="th1">Supply Type Name</th>
			<th class="th1">Entry Date</th>
			<th class="th1">Last Updated By</th>
			<th class="th1">Last Update</th>
		</tr>

		<c:forEach var="supplySearch" items="${suppliesTypeSearch}">
			<tr class="records">
				<td id="sId"><c:out value="${supplySearch.supplyTypeId}" /></td>
				<td id="sTn"><c:out value="${supplySearch.typeName}" /></td>
				<td id="sD"><c:out value="${supplySearch.entryDate}" /></td>
				<td id="sLu"><c:out value="${supplySearch.lastUser}" /></td>
				<td id="sLud"><c:out value="${supplySearch.lastUpdate}" /></td>
			</tr>
		</c:forEach>
	</table>

</body>
<script>
	var table = $('supplyTypeTable');
	for (var i = 1; i < table.rows.length; i++) {
		table.rows[i].onclick = function() {
			$("txtSupplyTypeId").value = this.cells[0].innerHTML;
			$("txtSupplyTypeName").value = this.cells[1].innerHTML;
		};
	}
</script>
</html>