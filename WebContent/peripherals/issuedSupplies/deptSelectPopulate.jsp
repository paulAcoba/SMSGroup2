<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>

<c:forEach var="dList" items="${deptList}">
	<option value="${dList.deptId}"><c:out value="${dList.deptName}"></c:out></option>
</c:forEach>