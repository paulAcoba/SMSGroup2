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
	<c:forEach var="itList" items="${itemLists}">
		<c:if test="${itList.supplyId==isup.supplyId && itList.obsoleteTag == 'N'}">
			<tr id="${isup.issueId}">
				<td><c:out value="${isup.issueId}"></c:out></td>
				<td>
					<c:if test="${itList.supplyId==isup.supplyId }">
							<input type="hidden" value="${itList.supplyId}">
							<c:out value="${itList.itemName}"></c:out>
					</c:if>
				</td>
				<td><c:out value="${isup.quantity}"></c:out></td>
				<td><c:out value="${isup.requestor}"></c:out></td>
				<td>
					<c:forEach var="dList" items="${deptList}">
						<c:if test="${dList.deptId==isup.deptId}">
							<input type="hidden" value="${dList.deptId}">
							<c:out value="${dList.deptName}"></c:out>
						</c:if>
					</c:forEach>
				</td>
				<td><input type="hidden" value="<fmt:formatDate type="date" pattern="yyyy-MM-dd" value="${isup.issueDate}"></fmt:formatDate>"><fmt:formatDate type="date" pattern="dd-MMM-yyyy" value="${isup.issueDate}"></fmt:formatDate></td>
				<td><c:out value="${isup.lastUser}"></c:out></td>
				<td><fmt:formatDate type="date" pattern="dd-MMM-yyyy" value="${isup.lastUpdate}"></fmt:formatDate></td>
			</tr>
		</c:if>
	</c:forEach>
</c:forEach>
	