<%@page pageEncoding="UTF-8" contentType="text/html; charset=UTF-8"%>
<%@ include file="/WEB-INF/views/include.jsp"%>


<!-- ======================= header ===========================-->
<jsp:include page="/WEB-INF/views/headerKostfChildWindow.jsp" />
<!-- =====================end header ==========================-->

<link href="resources/espedsgkostf.css" rel="stylesheet" type="text/css"/>

<script type="text/javascript">
	"use strict";
 	let caller = "#${model.caller}";
	
	jq(document).ready(function() {
		
		console.log("Innan initValufSearch, caller=", caller);
		
		initValufSearch(caller);
	});	

</script>

<div class="container-fluid">

	<div class="form-row">
		<div class="form-group pr-2 pl-1">
			<label for="selectValkod" class="col-form-label-sm mb-0">Valutakod</label>
			<input type="text" class="form-control form-control-sm" id="selectValkod" size="4" maxlength="3">	
		</div>


		<div class="form-group col-2 align-self-end">
			<div class="float-md-right">
				<button class="btn inputFormSubmit" onclick="loadValuf();" id="submitBtn">Søk</button>
			</div>
		</div>
	</div>

	<div>
		<table class="display compact cell-border responsive nowrap" id="valufTable">
			<thead class="tableHeaderField">
				<tr>
					<th>valkod</th>
					<th>Velg</th>					
					<th>valtek</th>					
				</tr>
			</thead>
		</table>
	</div>
  
</div>