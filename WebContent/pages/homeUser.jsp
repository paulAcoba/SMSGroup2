<script> var contextPath = "${pageContext.request.contextPath}";</script>
<script src='js/prototype.js'></script>
<div>
<form>
	<fieldset>
	<h1 style="color:white"> WELCOME TO USER HOMEPAGE </h1>
	</fieldset>
	<input type="Button" id="btnAddStocks" value="Add Stocks" />
</form>
</div>
<script>
	$("btnAddStocks").observe("click", openStocks);
	
	function openStocks() {
		new Ajax.Request("${pageContext.request.contextPath}/stocks", {
			method : "get",
			onComplete : function(response) {
				$("wrapper").update(response.responseText);
			}
		});
	}
	
</script>