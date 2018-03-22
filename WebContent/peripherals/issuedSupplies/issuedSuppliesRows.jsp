<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"  %>
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