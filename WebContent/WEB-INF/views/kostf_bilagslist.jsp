<%@page pageEncoding="UTF-8" contentType="text/html; charset=UTF-8"%>
<%@ include file="/WEB-INF/views/include.jsp"%>

<!-- ======================= header ===========================-->
<jsp:include page="/WEB-INF/views/headerKostf.jsp" />
<!-- =====================end header ==========================-->

<!-- ======================= Bootstrap docs ===================-->
<!-- https://getbootstrap.com/docs/4.0/layout/overview/   -->

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

.form-control {
   padding: 3px 7px; /*Align to inputText*/
   width: max-content; /* enable witdh*/
   display: inline-block; /* no wrap in div*/
}

select.form-control:not([size]):not([multiple]) {
    height: calc(1.8rem + 2px);  /*Align to inputText*/
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
			"order" : [ [ 3, "desc" ] ],
			"aoColumns" : [ {
				"mData" : "kabnr2"
			}, {
				"mData" : "kabnr"
			}, {
				"mData" : "kafnr"
			},{
				"mData" : "kabdt"
			},{
				"mData" : "kapmn"
			},{
				"mData" : "kapår"
			},{
				"mData" : "kalnr"
			},{
				"mData" : "kasg"
			},{
				"mData" : "katxt"
			}],
			"lengthMenu" : [ 25, 75, 100 ],
			"language" : {
				"url" : getLanguage('NO')
			}

		});

		jq.unblockUI();

		
	}

</script>

<div class="container-fluid">

	<div class="padded-row-small"></div>	

	<nav>
	  <div class="nav nav-tabs" id="nav-tab" role="tablist">
	    <a class="nav-item nav-link active" onClick="setBlockUI(this);" href="kostf_bilagslist.do"><strong>&nbsp;&nbsp;Bilager&nbsp;&nbsp;</strong>
		<img style="vertical-align: middle;" src="resources/images/list.gif">
	    </a>
		<a class="nav-item nav-link disabled" onClick="setBlockUI(this);" href="#"><strong>&nbsp;&nbsp;Kostnadsføring&nbsp;&nbsp;</strong>
		</a>
	  </div>
	</nav>

	<div class="padded-row-small left-right-border"></div>	

	<div class="row left-right-border no-gutters">
		<div class="col-1 p-1">
			<label for="selectBilagsnr">Bilagsnr</label>
			<br>
			<input type="text" class="inputText" id="selectBilagsnr" size="8" maxlength="7">	
		</div>
		<div class="col-1 p-1">
			<label for="selectInnregnr">Innreg.nr</label>
			<br>
			<input type="text" class="inputText" id="selectInnregnr" size="8" maxlength="6"/>
		</div>
		<div class="col-1 p-1">
			<label for="selectFaktnr">Fakturanr</label>
			<br>
			<input type="text" class="inputText" id="selectFaktnr" size="14" maxlength="13">
		</div>
		<div class="col-1 p-1">
			<label for="selectSuppliernr">Leverandørnr</label>
			<br>
			<input type="text" class="inputText" id="selectSuppliernr" size="9" maxlength="8">
		</div>
		<div class="col-1 p-1">
			<label for="selectAttkode">Att.kode</label>
			<br>
			<input type="text" class="inputText" id="selectAttkode" size="4" maxlength="3">
		</div>
		<div class="col-2 p-1">
			<label for="selectKomment">Kommentar</label>
			<br>
			<input type="text" class="inputText" id="selectKomment" size="36" maxlength="35">
		</div>
		<div class="col-1 p-1">
			<label for="selectFradato">Fra&nbsp;bilagsdato</label>
			<br>
			<input type="text" class="inputText" id="selectFradato" size="9" maxlength="8">
		</div>
		<div class="col-1 p-1">
			<label for="selectFraperaar">Fra&nbsp;periode</label>
			<br>
			<input type="text" class="form-control" id="selectFrapermnd" placeholder="mm" size="3" maxlength="2">-
			<input type="text" class="form-control" id="selectFraperaar" placeholder="yy" size="3" maxlength="2">
		</div>
		<div class="col-1 p-1">
			<label for="selectTilperaar">Til&nbsp;periode</label>
			<br>
			<input type="text" class="form-control" id="selectTilpermnd"  placeholder="mm" size="3" maxlength="2">-
			<input type="text" class="form-control" id="selectTilperaar"  placeholder="yy" size="3" maxlength="2">
		</div>

	</div>
	
	<div class="row left-right-border no-gutters">
		<div class="col-1 p-1">
			<label for="selectReklamasjon">
				<img onMouseOver="showPop('reklCode_info');" onMouseOut="hidePop('reklCode_info');"style="vertical-align:bottom;" width="12px" height="12px" src="resources/images/info3.png" alt="info">
				Kun&nbsp;Rekl.
			</label>
			<div class="text11" style="position: relative;" align="left">
				<span style="position:absolute; left:0px; top:0px; width:200px" id="reklCode_info" class="popupWithInputText"  >
         			<b>Kun&nbsp;Reklamasjon</b><br>
         			<label>S= Sendte</label>
					<label>O= Ferdig oppgjort</label>
				</span>
			</div>			
		    <select class="form-control" id="selectReklamasjon">
		      <option value="">-velg-</option>
		      <option value="S">S</option>
		      <option value="O">O</option>
		    </select>
		</div>
		<div class="col-2 p-1">
			<label for="selectFrisokKode">Fri&nbsp;søkvei</label>
			<br>
			<input type="text" class="form-control" placeholder="kode" id="selectFrisokKode" size="4" maxlength="3">-
			<input type="text" class="form-control" placeholder="tekst" id="selectFrisokTxt" size="16" maxlength="15">
		</div>
		<div class="col-2 p-1">
			<label for="selectStatus">
				<img onMouseOver="showPop('statusCode_info');" onMouseOut="hidePop('statusCode_info');"style="vertical-align:bottom;" width="12px" height="12px" src="resources/images/info3.png" alt="info">
				Status
			</label>
			<div class="text11" style="position: relative;" align="left">
				<span style="position:absolute; left:0px; top:0px; width:350px" id="statusCode_info" class="popupWithInputText"  >
         			<b>Status</b><br>
         			<label>A= arbeider med nyregistrert  bilag</label>
					<label>B= arbeider med tildligere innregistr bilag</label>
					<label>D= slettet bilag</label>
					<label>G= ferdigmeldt bilag til økonomi</label>
					<label>O= oppdatert bilag i økonomi</label>
				</span>
			</div>
		    <select class="form-control" id="selectStatus">
		      <option value="">-velg-</option>
		      <option value="A">A</option>
		      <option value="B">B</option>
		      <option value="D">D</option>
		      <option value="G">G</option>
		      <option value="O">O</option>
		    </select>
		</div>

		<div class="col-6 align-self-end p-1">
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
					<th>Bilagsdato</th>
					<th>Periode(mån)</th>
					<th>Periode(år)</th>
					<th>Leverandørnr</th>
					<th>Att.kode</th>
					<th>Kommentar</th>
				</tr>
			</thead>
		</table>
	</div>	
 

  
</div>

<!-- ======================= footer ===========================-->
<jsp:include page="/WEB-INF/views/footer.jsp" />
<!-- =====================end footer ==========================-->

