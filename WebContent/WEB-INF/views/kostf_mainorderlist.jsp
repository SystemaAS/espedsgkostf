<%@page pageEncoding="UTF-8" contentType="text/html; charset=UTF-8"%>
<%@ include file="/WEB-INF/views/include.jsp"%>

<!-- ======================= header ===========================-->
<jsp:include page="/WEB-INF/views/headerKostf.jsp" />
<!-- =====================end header ==========================-->


<style>
.left-right-border {
   border-style: solid; 
   border-left-width: 1px; 
   border-right-width: 1px; 
   border-top-width: 0px;
   border-bottom-width: 0px;
   border-color: #D5E0CE; 
 }
</style>

<script type="text/javascript">
	"use strict";

	var baseUrl = "/syjserviceskostf/kosta?user=${user.user}";
	
	function load_data() {
		var runningUrl;
		runningUrl= getRunningUrl(baseUrl);

		console.log("runningUrl=" + runningUrl);

		jq.blockUI({
			message : BLOCKUI_OVERLAY_MESSAGE_DEFAULT
		});


	var kostaTable = jq('#kostaTable').DataTable({
 			"dom" : '<"top">t<"bottom"flip><"clear">',
 			responsive : true,
			select : true,
			destroy : true,
			"sAjaxSource" : runningUrl,
			"sAjaxDataProp" : "",
			"order" : [ [ 2, "desc" ] ],
			"aoColumns" : [ {
				"mData" : "kabnr2"
			}, {
				"mData" : "kabnr"
			}, {
				"mData" : "kafnr"
			},{
				"mData" : "kalnr"
			},{
				"mData" : "kasg"
			}],
			"lengthMenu" : [ 25, 75, 100 ],
			"language" : {
				"url" : getLanguage('NO')
			}

		});

		jq.unblockUI();

		
	}

	window.addEventListener('error', function(e) {
		var error = e.error;
		jq.unblockUI();
		console.log("Event e", e);

		alert('Uforutsett fel har intreffet.');

	});
</script>

<!-- https://getbootstrap.com/docs/4.0/components/navs/   -->

<div class="container-fluid">

	<div class="padded-row-small"></div>	

	<nav>
	  <div class="nav nav-tabs" id="nav-tab" role="tablist">
	    <a class="nav-item nav-link active" onClick="setBlockUI(this);" href="customer.do"><strong>&nbsp;&nbsp;Arbete med bilag&nbsp;&nbsp;</strong>
	    </a>
		<a class="nav-item nav-link" onClick="setBlockUI(this);" href="supplier.do"><strong>&nbsp;&nbsp;Kostnadsføring&nbsp;&nbsp;</strong>
		</a>
	  </div>
	</nav>

	<div class="padded-row-small left-right-border"></div>	

 
	<div class="row left-right-border no-gutters">
		<div class="col-md-1">
			<label for="selectBilagsnr">&nbsp;Bilagsnr&nbsp;</label>
			<input type="text" class="inputText" name="selectBilagsnr" id="selectBilagsnr" size="9" maxlength="8"/>&nbsp;
		</div>
		<div class="col-md-1">
			<label for="selectInnregnr">&nbsp;Innreg.nr&nbsp;</label>
			<input type="text" class="inputText" name="selectInnregnr" id="selectInnregnr" size="9" maxlength="8"/>&nbsp;
		</div>
		<div class="col-md-1">
			<label for="selectFaktnr">Fakturanr&nbsp;</label>
			<input type="text" class="inputText" name="selectFaktnr" id="selectFaktnr" size="11" maxlength="10">
		</div>
		<div class="col-md-1">
			<label for="selectSuppliernr">Leverandørnr&nbsp;</label>
			<input type="text" class="inputText" name="selectSuppliernr" id="selectSuppliernr" size="11" maxlength="10">
		</div>
		<div class="col-md-1">
			<label for="selectAttkode">Attenstasjonskode&nbsp;</label>
			<input type="text" class="inputText" name="selectAttkode" id="selectAttkode" size="11" maxlength="10">
		</div>


		<div class="col-md-2">
			<br>
			<button class="btn inputFormSubmit" onclick="load_data()" autofocus>Søk</button>
		</div>
	</div>

	<div class="padded-row-small left-right-border no-gutters">&nbsp;</div>
	
	<div class="panel-body left-right-border no-gutters">
		<table class="table table-striped table-bordered table-hover" id="kostaTable">
			<thead class="tableHeaderField">
				<tr>
					<th>Bilagsnr</th>
					<th>Innreg.nr</th>
					<th>Fakturanr</th>
					<th>Leverandørnr</th>
					<th>Attenstasjonskode</th>
				</tr>
			</thead>
		</table>
	</div>	
  
</div>

<!-- ======================= footer ===========================-->
<jsp:include page="/WEB-INF/views/footer.jsp" />
<!-- =====================end footer ==========================-->

