<%@page pageEncoding="UTF-8" contentType="text/html; charset=UTF-8"%>
<%@ include file="/WEB-INF/views/include.jsp"%>


<!-- ======================= header ===========================-->
<jsp:include page="/WEB-INF/views/headerKostfChildWindow.jsp" />
<!-- =====================end header ==========================-->

<style type="text/css">
.ui-datepicker {
	font-size: 9pt;
}
</style>

<script type="text/javascript">
	"use strict";

	var levefUrl = "/syjserviceskostf/syjsLEVEF?user=${user.user}";
	
// 	function load_data() {
// 		var runningUrl = baseUrl;

// 		var selectedLevnr = jq('#selectLevnr').val();
// 		var selectedLnavn = jq('#selectLnavn').val();

// 		if (selectedLevnr != "") {
// 			runningUrl = runningUrl + "&levnr=" + selectedLevnr;
// 		} 
// 		if (selectedLnavn != "") {
// 			runningUrl = runningUrl + "&lnavn=" + selectedLnavn;
// 		} 		
		
// 		console.log("runningUrl=" + runningUrl);

// 		setBlockUI();

// 		jq('#supplierTable').DataTable({
// 			"dom" : '<"top">t<"bottom"flip><"clear">',
// 			"ajax": {
// 		        "url": runningUrl,
// 		        "dataSrc": ""
// 		    },	
// 			mark: true,			
// 			responsive : true,
// 			select : true,
// 			destroy : true,
// 			"order" : [ [ 1, "desc" ] ],
// 			"columns" : [ 
// 				{"data" : "levnr"}, 
// 				{"data" : "lnavn"},
// 				{"data" : "adr1"},
// 				{"data" : "adr2"},
// 				{"data" : "adr3"},
// 				{"data" : "postnr"},
// 				{"data" : "land"}
// 			 ],
// 			"lengthMenu" : [ 10, 25, 75],
// 			"language" : {
// 				"url" : getLanguage('NO')
// 			}

// 		});

// 		unBlockUI();

// 	}
	
	jq(document).ready(function() {

		initLevefSearch();
		
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
				<button class="btn inputFormSubmit" onclick="loadLevef();" id="loadLevef"  autofocus>Søk</button>
			</div>
		</div>
	</div>

	<div>
		<table class="display compact cell-border responsive nowrap" id="levefTable">
			<thead class="tableHeaderField">
				<tr>
					<th>Levnr</th>
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