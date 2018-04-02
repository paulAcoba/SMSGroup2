<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<script type="text/javascript" src="js/prototype.js"></script>
<jsp:include page="../peripherals/header.jsp"></jsp:include> <!-- 3/27/2018 edit -->

<div id="dataFormAdd"  class="panel panel-info">
<div class="panel-heading">Add Supply</div>
<div class="panel-body">
<div class="alert alert-danger" id="alert" hidden>${message}</div>
	
	<table id="dataFormTable">
		<tr>


			<!-- 	<td><label>Supply Type: </label></td>
						<td><input type="text" id="txtsuType"></td> -->


			<td><label>Supply Type:</label></td>
			<td><select id="txtsuType" class="form-control">
				<%-- 	<c:forEach var="itList" items="${supType}">
						<option value="${itList.supplyType}"><c:out
								value="${itList.typeName}"></c:out></option>
					</c:forEach> --%>
			</select></td>


		</tr>
		<tr>
			<td><label>Item Name:</label></td>
			<td><input type="text" id="txtitName" class="form-control"></td>
		</tr>
		<tr>
			<td><label>Item Unit:</label></td>
			<td><input type="text" id="txtitUnit" class="form-control"></td>
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
			<td><input type="text" id="txtlocation" class="form-control"></td>
		</tr>
		<tr>
			<td><label>Entered Date:</label></td>
			<td><input type="date" id="dateEntered" class="form-control"></td>
		</tr>

		<tr>
			<td><label>Reorder Level:</label></td>
			<td><input type="text" id="txtreLevel"
				onkeydown='return (event.which >=48 && event.which <=57) || event.which ===8 || event.which == 46' class="form-control" ></td>
				</tr>
				<td><label>Actual Count: </label></td> <td><input type="text" 
				id="txtacCount"
				onkeydown='return (event.which >= 48 && event.which <= 57) 
   || event.which == 8 || event.which == 46' class="form-control" />
		</tr>



		<tr>
			<form>
				<td><label>Remarks :</label></td>
				<td><textarea rows="5" cols="30" id="remarks" class="form-control">
							</textarea></td>
			</form>


		</tr>
		<tr>
			<td colspan="2"><input type="button" name="btnSave" id="btnSave"
				value="Save" class="btn btn-primary"> <input type="button" name="btnCancel"
				id="btnCancel" value="Cancel" class="btn btn-danger"></td>
		</tr>
	</table>

</div>
</div>


<script>
//alert('The letters of the item unit entered should not exceed to 10');
	
	$('btnSave').observe("click", function() {
		try {
			

			if (!$F('txtsuType') || !$F('txtitName') || !$F('txtitUnit') || !$F('txtacCount') || !$F('dateEntered')) {
				$('alert').className += ' show';
				$('alert').update("Please fill up all the fields!");
			}else if (isNaN($F('txtreLevel')) || isNaN($F('txtacCount'))) {
				$('alert').className += ' show';
				$('alert').update('Enter proper number'); 
			
			} else if ($F('txtitName').length > 100 ) {
				$('alert').className += ' show';
				$('alert').update('The letters of the item name entered should not exceed to 100');

			}  else if ($F('txtitUnit').length > 10 ) {
				$('alert').className += ' show';
				$('alert').update('The letters of the item unit entered should not exceed to 10');

			}  else if ($F('txtlocation').length > 100 ) {
				$('alert').className += ' show';
				$('alert').update('The letters of the location entered should not exceed to 100');

			}  else if ($F('remarks').length > 1000 ) {
				$('alert').className += ' show';
				$('alert').update('The letters of the remarks entered should not exceed to 1000');

			} else if ($F('txtreLevel').length > 4 || $F('txtacCount').length > 4 ) {
				$('alert').className += ' show';
				$('alert').update('The inpputed numbers should only contain 4 digits');

			} else {

				$('alert').className += 'alert alert-danger';
				
				var obsolete = "";
				if ($("rdYes").checked) {
					obsolete = "Y";
				} else if ($("rdNo").checked) {
					obsolete = "N"
				}

				
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
			//	alert('cancelshowamain');
			}
		});
	});
</script>
