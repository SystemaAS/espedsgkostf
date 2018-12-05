<%@page pageEncoding="UTF-8" contentType="text/html; charset=UTF-8"%>
<%@ include file="/WEB-INF/views/include.jsp"%>


<!-- ======================= header ===========================-->
<jsp:include page="/WEB-INF/views/headerKostfChildWindow.jsp" />
<!-- =====================end header ==========================-->

<link href="resources/espedsgkostf.css" rel="stylesheet" type="text/css"/>

<script type="text/javascript">
	"use strict";
	var levefUrl = "/syjserviceskostf/syjsLEVEF?user=${user.user}";
 	let caller = "#${model.caller}";
	
	jq(document).ready(function() {
		initLevefSearch(caller);
	});	

</script>

<div class="container-fluid">

	<div class="form-row">
		<div class="form-group pr-2 pl-1">
			<label for="selectLevnr" class="col-form-label-sm mb-0">Lev.nr</label>
			<input type="text" class="form-control form-control-sm" id="selectLevnr" size="9" maxlength="8">	
		</div>

		<div class="form-group pr-2 pl-1">
			<label for="selectLnavn" class="col-form-label-sm mb-0">Lev.navn</label>
			<input type="text" class="form-control form-control-sm" id="selectLnavn" size="11" maxlength="10">	
		</div>

		<div class="form-group col-2 align-self-end">
			<div class="float-md-right">
				<button class="btn inputFormSubmit" onclick="loadLevef();" id="submitBtn"  autofocus>Søk</button>
			</div>
		</div>
	</div>

	<div>
		<table class="display compact cell-border responsive nowrap" id="levefTable">
			<thead class="tableHeaderField">
				<tr>
					<th>Levnr</th>
					<th>Velg</th>					
					<th>Navn</th>
					<th>Adr</th>
					<th>Adr</th>
					<th>Adr</th>
					<th>Postnr</th>
					<th>Land</th>					
				</tr>
			</thead>
		</table>
	</div>
  
</div>