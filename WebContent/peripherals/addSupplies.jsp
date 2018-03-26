<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<script type="text/javascript" src="js/prototype.js"></script>


<div id="dataForm">
	<table id="dataFormTable">
		<tr>


			<!-- 	<td><label>Supply Type: </label></td>
						<td><input type="text" id="txtsuType"></td> -->


			<td><label>Supply Type:</label></td>
			<td><select id="txtsuType">
				<%-- 	<c:forEach var="itList" items="${supType}">
						<option value="${itList.supplyType}"><c:out
								value="${itList.typeName}"></c:out></option>
					</c:forEach> --%>
			</select></td>


		</tr>
		<tr>
			<td><label>Item Name:</label></td>
			<td><input type="text" id="txtitName"></td>
		</tr>
		<tr>
			<td><label>Item Unit:</label></td>
			<td><input type="text" id="txtitUnit"></td>
		</tr>
		<tr>
			<td><label>Obsolete Tag:</label></td>
			<td><form>
					<input type="radio" name="obsolete" value="Y" id="rdYes">Yes
					<input type="radio" name="obsolete" value="N" id="rdNo"
						checked="checked">No
				</form></td>
		</tr>
		<tr>
			<td><label>Location:</label></td>
			<td><input type="text" id="txtlocation"></td>
		</tr>
		<tr>
			<td><label>Entered Date:</label></td>
			<td><input type="date" id="dateEntered"></td>
		</tr>

		<tr>
			<td><label>Reorder Level:</label></td>
			<td><input type="text" id="txtreLevel"
				onkeydown='return (event.which >=48 && event.which <=57) || event.which ===8 || event.which == 46'>
				<label>Actual Count: </label> <input type="text" class="quantity"
				id="txtacCount"
				onkeydown='return (event.which >= 48 && event.which <= 57) 
   || event.which == 8 || event.which == 46' />
		</tr>



		<tr>
			<form>
				<td><label>Remarks :</label></td>
				<td><textarea rows="5" cols="30" id="remarks">
							</textarea></td>
			</form>


		</tr>
		<tr>
			<td colspan="2"><input type="button" name="btnSave" id="btnSave"
				value="Save"> <input type="button" name="btnCancel"
				id="btnCancel" value="Cancel"></td>
		</tr>
	</table>
</div>


<script>
	$('btnSave').observe("click", function() {
		try {
			

			if (!$F('txtitName') || !$F('txtitUnit') || !$F('txtacCount') || !$F('dateEntered')) {
				alert("Please fill up all the fields!");
			} else if ($F('txtitName').length > 100 ) {

				alert('The letters of the item name entered should not exceed to 100');

			}  else if ($F('txtitUnit').length > 10 ) {

				alert('The letters of the item unit entered should not exceed to 10');

			}  else if ($F('txtlocation').length > 100 ) {

				alert('The letters of the location entered should not exceed to 100');

			}  else if ($F('remarks').length > 1000 ) {

				alert('The letters of the remarks entered should not exceed to 1000');

			} else if ($F('txtreLevel').length > 4 || $F('txtacCount').length > 4 ) {

				alert('The inpputed numbers should only contain 4 digits');

			} else {

				var obsolete = "";
				if ($("rdYes").checked) {
					obsolete = "Y";
				} else if ($("rdNo").checked) {
					obsolete = "N"
				}

				alert("HERE");
				new Ajax.Request(contextPath + "/supplymaintenance", {
					method : "POST",
					parameters : {
						action : "addSupply",
						supplyType : $F('txtsuType'),
						itemName : $F('txtitName'),
						itemUnit : $F('txtitUnit'),
						obsoleteTag : obsolete,
						location : $F('txtlocation'),
						reorderLevel : $F('txtreLevel'),
						remarks : $F('remarks'),
						actualCount : $F('txtacCount'),
						dateAdded : $F('dateEntered')

					},
					onComplete : function(response) {
						//alert(response.responseText);
						$('supplyMaintenances').update(response.responseText);
						populate();
						alert('Product has been added');

					}
				});
			}
		} catch (e) {
			e.toString(e)
		}
	});

	$('btnCancel').observe("click", function() {

		new Ajax.Request(contextPath + "/supplymaintenance", {
			method : "POST",
			parameters : {
				action : "cancel"
			},
			onComplete : function(response) {
				$('wrapper').update(response.responseText);
				populate();
				alert('cancelshowamain');
			}
		});
	});
</script>
