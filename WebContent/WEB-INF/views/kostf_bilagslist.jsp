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
   margin-right: 10;
   margin-left: 5;
}
.left-right-bottom-border {
   border-style: solid; 
   border-left-width: 1px; 
   border-right-width: 1px; 
   border-top-width: 0px;
   border-bottom-width: 1px;
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
			"order" : [ [ 0, "desc" ] ],
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
			},{
				"mData" : "katxt"
			},{
				"mData" : "kabdt"
			}],
			"lengthMenu" : [ 25, 75, 100 ],
			"language" : {
				"url" : getLanguage('NO')
			}

		});

		jq.unblockUI();

		
	}

</script>

<!-- https://getbootstrap.com/docs/4.0/components/navs/   -->

<div class="container-fluid">

	<div class="padded-row-small"></div>	

	<nav>
	  <div class="nav nav-tabs" id="nav-tab" role="tablist">
	    <a class="nav-item nav-link active" onClick="setBlockUI(this);" href="kostf_bilagslist.do"><strong>&nbsp;&nbsp;Bilager&nbsp;&nbsp;</strong>
		<img style="vertical-align: middle;" src="resources/images/list.gif" border="0" alt="general list">
	    </a>
		<a class="nav-item nav-link disabled" onClick="setBlockUI(this);" href="#"><strong>&nbsp;&nbsp;Kostnadsføring&nbsp;&nbsp;</strong>
		</a>
	  </div>
	</nav>

	<div class="padded-row-small left-right-border"></div>	

 
	<div class="row left-right-border no-gutters">
		<div class="col-md-1 p-1">
			<label for="selectBilagsnr">Bilagsnr</label>
			<input type="text" class="inputText" name="selectBilagsnr" id="selectBilagsnr" size="9" maxlength="8"/>
		</div>
		<div class="col-md-1 p-1">
			<label for="selectInnregnr">Innreg.nr</label>
			<input type="text" class="inputText" name="selectInnregnr" id="selectInnregnr" size="9" maxlength="8"/>
		</div>
		<div class="col-md-1 p-1">
			<label for="selectFaktnr">Fakturanr</label>
			<input type="text" class="inputText" name="selectFaktnr" id="selectFaktnr" size="11" maxlength="10">
		</div>
		<div class="col-md-1 p-1">
			<label for="selectSuppliernr">Leverandørnr</label>
			<input type="text" class="inputText" name="selectSuppliernr" id="selectSuppliernr" size="11" maxlength="10">
		</div>
		<div class="col-md-1 p-1">
			<label for="selectAttkode">Att.kode</label>
			<input type="text" class="inputText" name="selectAttkode" id="selectAttkode" size="11" maxlength="10">
		</div>
		<div class="col-md-1 p-1">
			<label for="selectKomment">Kommentar</label>
			<input type="text" class="inputText" name="selectKomment" id="selectKomment" size="11" maxlength="10">
		</div>
		<div class="col-md-1 p-1">
			<label for="selectFradato">Fra&nbsp;bilagsdato</label>
			<input type="text" class="inputText" name="selectFradato" id="selectFradato" size="11" maxlength="10">
		</div>


		<div class="col-md-2 p-1">
			<br>
			<button class="btn inputFormSubmit" onclick="load_data()" id="submitBtn"  autofocus>Søk</button>
		</div>
	</div>

	<div class="padded-row-small left-right-border no-gutters">&nbsp;</div>
	
	<div class="panel-body left-right-bottom-border no-gutters">
		<table class="table table-striped table-bordered table-hover" id="kostaTable">
			<thead class="tableHeaderField">
				<tr>
					<th>Bilagsnr</th>
					<th>Innreg.nr</th>
					<th>Fakturanr</th>
					<th>Leverandørnr</th>
					<th>Att.kode</th>
					<th>Kommentar</th>
					<th>Bilagsdato</th>
				</tr>
			</thead>
		</table>
	</div>	
  
</div>

<!-- ======================= footer ===========================-->
<jsp:include page="/WEB-INF/views/footer.jsp" />
<!-- =====================end footer ==========================-->

