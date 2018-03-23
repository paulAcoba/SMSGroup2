<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>

<c:forEach var="itList" items="${itemLists}">
	<option value="${itList.supplyId}"><c:out value="${itList.itemName}"></c:out></option>
</c:forEach>