<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<option value=""></option>
<c:forEach var="itList" items="${supType}">

	
	<option value="${itList.supplyTypeId}"><c:out
			value="${itList.typeName}"></c:out></option>


</c:forEach>

