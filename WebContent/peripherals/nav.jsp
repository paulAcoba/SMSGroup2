<nav class="navbar navbar-inverse">
  <div class="container-fluid">
    <div class="navbar-header">
      <a class="navbar-brand" href="#">SMS</a>
    </div>
    <ul class="nav navbar-nav">
      <li><a href="#">Home</a></li>
      <li><a href="gate">Profile</a></li>
      <li><a href="maintenancetab">Maintenance</a></li>
      <li><a href="issuedSupply">Supply Issuance</a></li>
      <li><a href="#">Add Stocks</a></li>
    </ul>
  </div>
</nav>

<script>

function sels() {
	new Ajax.Request(contextPath + "/issuedSupply", {
		method : "POST",
		parameters : {
			action : "sels"
		},
		onComplete : function(response) {
			$('selItems').update(response.responseText);
		}
	});
}

function depts() {
	new Ajax.Request(contextPath + "/issuedSupply", {
		method : "POST",
		parameters : {
			action : "depts"
		},
		onComplete : function(response) {
			$('selDept').update(response.responseText);
		}
	});
}

function clickRow(){
	var table = $('dataTable');

	for (var i = 1; i < table.rows.length; i++) {
		table.rows[i].onclick = function() {
			//alert(this.cells[1].innerHTML);
			var selID = this.cells[1].children[0].value;
			var deptID = this.cells[4].children[0].value;

			$('issueId').update("Issue ID");
			$('txtIssueId').update(this.cells[0].innerText);
			$('selItems').value = selID;
			$('txtOldItem').value = selID;
			$('txtQuantity').value = this.cells[2].innerText;
			$('txtOldQuantity').value = this.cells[2].innerText;
			$('txtRequestedBy').value = this.cells[3].innerText;
			$('selDept').value = deptID;
			$('txtIssueDate').value = this.cells[5].children[0].value;
		}
	}
}

function refresh() {
	new Ajax.Request(contextPath + "/issuedSupply",{
		method : "POST",
		parameters : {
			action : "refresh"
		},
		onComplete : function(response) {
			$('dataTable').update(response.responseText);
			sels();
			depts();
			clear();

			clickRow();
		}
	});
}

</script>