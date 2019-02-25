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
		
		initKodfriSearch(caller);

	});	

</script>

<div class="container-fluid">

	<div class="form-row">
		<div class="form-group pr-2 pl-1">
			<label for="selectKffsotxt" class="col-form-label-sm mb-0">Beskrivelse</label>
			<input type="text" class="form-control form-control-sm" id="selectKffsotxt" size="30" maxlength="30">	
		</div>

		<div class="form-group col-2 align-self-end">
			<div class="float-md-right">
				<button class="btn inputFormSubmit" onclick="loadKodfri();" id="submitBtn">Søk</button>
			</div>
		</div>
	</div>

	<div>
		<table class="display compact cell-border responsive nowrap" id="kodfriTable">
			<thead class="tableHeaderField">
				<tr>
					<th>Kode</th>
					<th>Velg</th>					
					<th>Beskrivelse</th>
				</tr>
			</thead>
		</table>
	</div>
  
</div>