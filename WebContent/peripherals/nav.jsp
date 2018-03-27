<nav class="navbar navbar-inverse">
  <div class="container-fluid">
    <div class="navbar-header">
      <a class="navbar-brand" href="#">SMS</a>
    </div>
    <ul class="nav navbar-nav">
      <li><a href="#">Home</a></li>
      <% com.cpi.entity.User user = new com.cpi.entity.User();
      	user = (com.cpi.entity.User) session.getAttribute("activeUser");
      	if(user.getUserId() == "A"){
      %>
      <li><a href="maintenancetab">Maintenance</a></li>
      <% } %>
      <li><a href="issuedSupply">Supply Issuance</a></li>
      <li><a href="stocks">Add Stocks</a></li>
   	  <li style="position:absolute; left: 93%"><a href="gate" style="float: right;">Profile</a></li>
    </ul>
  </div>
</nav>