<div id="nav">
	<div class="btn-group">
	<input type="button" name="btnHome" id="btnHome" class="btn btn-primary" value="Home">
	<input type="button" name="btnMaintenance" id="btnMaintenance" class="btn btn-primary" value="Maintenance">
	<input type="button" name="btnIssue" id="btnIssue" class="btn btn-primary" value="Supply Issuance">
	<input type="button" name="btnStocksAdd" id="btnStocksAdd" class="btn btn-primary" value="Add Stocks">
	<input type="button" name="btnUpdateProfile" id="btnUpdateProfile" class="btn btn-primary" value="Profile">
	</div>
</div>


<script>

$("btnUpdateProfile").observe("click", function(){
	new Ajax.Request(contextPath + "/gate", {
		method: "POST",
		parameters: {
			gateKey: "userUpdateProfile"
		},
		onComplete: function(response) {
			$("wrapper").update(response.responseText);
		}
	});
});

function toUpdateProfile() {
	new Ajax.Request(contextPath + "/enter", {
		method: "POST",
		parameters: {
			userId: $F("userId"),
			password: $F("password")
		},
		onComplete: function(response) {
			$("wrapper").update(response.responseText);
		}
	});
}

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

function toIssuePage(){
	new Ajax.Request(contextPath + "/issuedSupply",{
		method : "POST",
		parameters : {
			action : "toIssuePage"
		},
		onComplete : function(response) {
			$('wrapper').update(response.responseText);
			refresh();
			clear();
			//alert(8);
			
		}
	});
}
$('btnIssue').observe("click", function() {
	toIssuePage();
});
</script>