<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<jsp:include page="../peripherals/header.jsp"></jsp:include>

<div id="supplyMaintenanceTable" class="tableDiv">

	<table id="dataTable" class="table table-hover">
		<tr id="dataTableHeader">
			<th>Supply ID</th>
			<th>Supply Type</th>
			<th>Item Name</th>
			<th>Item Unit</th>
			<th>Obsolete Tag</th>
			<th>Location</th>
			<th>Reorder Level</th>
			<th>Actual Count</th>
			<th>Remarks</th>
			<th>Entry Date</th>
			<th>Last Updated By</th>
			<th>Last Update</th>
		</tr>
		<c:forEach var="items" items="${allItems}">
			<tr id="${items.supplyId}">
				<td><c:out value="${items.supplyId}"></c:out></td>
				
					<td><c:forEach var="items2" items="${supType}">
						<c:if test="${items2.supplyTypeId==items.supplyType}">
							<input type="hidden" value="${items2.supplyTypeId}">
							<c:out value="${items2.typeName}"></c:out>
						</c:if>
					</c:forEach>
					</td> 

					
				<td><c:out value="${items.itemName}"></c:out></td>
				<td><c:out value="${items.itemUnit}"></c:out></td>
				<td><c:out value="${items.obsoleteTag}"></c:out></td>
				<td><c:out value="${items.location}"></c:out></td>
				<td><c:out value="${items.reorderLevel}"></c:out></td>
				<td><c:out value="${items.actualCount}"></c:out></td>
				<td><c:out value="${items.remarks}"></c:out></td>
				<td><fmt:formatDate type="date" pattern="yyyy-MM-dd"
						value="${items.dateAdded}"></fmt:formatDate></td>
				<td><c:out value="${items.lastUser}"></c:out></td>
				<td><fmt:formatDate type="date" pattern="yyyy-MM-dd"
						value="${items.lastUpdate}"></fmt:formatDate></td>
						
						<!-- dd-MMM-yyyy -->
						
			</tr>
		</c:forEach>
	</table>
</div>

