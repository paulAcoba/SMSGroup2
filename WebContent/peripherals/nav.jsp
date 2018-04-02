<nav class="navbar navbar-inverse">
  <div class="container-fluid">
    <div class="navbar-header">
      <a class="navbar-brand" href="home">SMS</a>
    </div>
    <ul class="nav navbar-nav">
      <li><a href="home">Home</a></li>
      <%  ;
      	if(session.getAttribute("accessLevel").equals("A")){ %>
    	  <li><a href="maintenancetab">Maintenance</a></li>
      <% } %>
      <li><a href="issuedSupply">Supply Issuance</a></li>
      <li><a href="stocks">Add Stocks</a></li>
    </ul>
    <ul class="nav navbar-nav navbar-right">
   	  <li ><a href="gate" >Profile</a></li>
   	  <li ><a href="logout" >Logout</a></li>
    </ul>
  </div>
</nav>
<%  if(session.getAttribute("accessLevel").equals("U")){ %>
	<img src="${pageContext.request.contextPath}\\pages\\user.PNG" alt="Banner" class="pic">
<% }else{ %>
	<img src="${pageContext.request.contextPath}\\pages\\admin.PNG" alt="Banner" class="pic">
<% } %>