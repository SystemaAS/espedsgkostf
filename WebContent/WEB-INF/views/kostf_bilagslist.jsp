<%@page pageEncoding="UTF-8" contentType="text/html; charset=UTF-8"%>
<%@ include file="/WEB-INF/views/include.jsp"%>

<!-- ======================= header ===========================-->
<jsp:include page="/WEB-INF/views/headerKostf.jsp" />
<!-- =====================end header ==========================-->

<link href="resources/espedsgkostf.css" rel="stylesheet" type="text/css"/>

<script type="text/javascript">
	"use strict";
	var kostaUrl = "/syjserviceskostf/syjsKOSTA?user=${user.user}";
	var kodtsfUrl = "/syjserviceskostf/syjsKODTSF?user=${user.user}";

	var bilagUrl_read = "kostf_bilag_edit.do?user=${user.user}&action=2";
	var bilagUrl_delete = "kostf_bilag_edit.do?user=${user.user}&action=4";

	jq(document).ready(function() {
		
		initKosta();

 		jq.ajax({
			  type: 'GET',
			  url: kodtsfUrl,
			  dataType: 'json',
			  cache: false,
			  contentType: 'application/json',
			  success: function(data) {
			  	var len = data.length;
			  	var i = 0;
				let select_data = [];
				_.each(data, function( d) {
			  		select_data.push({
			  	        id: d.kosfsi,
			  	        text: d.kosfnv
			  		});
			  	 });
			  	
			  	//Inject dropdown
				jq('.selectAttkode-data-ajax').select2({
					 data: select_data,
					 language: "no",
					 escapeMarkup: function (markup) { return markup; }, // let our custom formatter work;formatData
					 templateResult: formatData,
					 templateSelection: formatDataSelection
				})	
				
			  }, 

			  error: function (jqXHR, exception) {
				    alert('Error loading ...look in console log.');
				    console.log(jqXHR);
			  }	
		});		

 		function formatData (data) {
			if (data.loading) {
				return data.text;
			}
 			console.log("data",data);
 			var markup = "<div>" + data.id ; 
 		 	markup += '<p class="text-md-left" style="font-size:75%;">' + data.text +'</p></div>';
 			  
 			return markup;
 		}

 		function formatDataSelection (data) {
 			  return data.id || data.text;
 		}
 		
 		
		jq('.selectAttkode-data-ajax').change(function() {
			var selected = jq('.selectAttkode-data-ajax').select2('data');
			jq('#selectAttkode').val(selected[0].id);
		});

 		jq('#submitBtn').click();
		
	
	});

	
</script>

<div class="container-fluid">

	<div class="padded-row-small"></div>	

	<nav>
	  <div class="nav nav-tabs" id="nav-tab" role="tablist">
	    <a class="nav-item nav-link active disabled">Bilager
			<img style="vertical-align: middle;" src="resources/images/list.gif">
	    </a>
		<a class="nav-item nav-link nav-new" onClick="setBlockUI();" href="${bilagUrl_create}">Lage ny bilag</a>
		
	  </div>
	</nav>

	<div class="padded-row-small left-right-border"></div>	

	<div class="form-row left-right-border">
		<div class="form-group pr-2 pl-1">
			<label for="selectBilagsnr" class="mb-0">Bilagsnr</label>
			<input type="text" class="form-control form-control-sm" id="selectBilagsnr" size="8" maxlength="7">	
		</div>
		<div class="form-group pr-2">
			<label for="selectInnregnr" class="mb-0">Innreg.nr</label>
			<input type="text" class="form-control form-control-sm" id="selectInnregnr" size="8" maxlength="7"/>
		</div>
		<div class="form-group pr-2">
			<label for="selectFaktnr" class="mb-0">Fakturanr</label>
			<input type="text" class="form-control form-control-sm" id="selectFaktnr"  size="13"  maxlength="13">
		</div>
		<div class="form-group pr-2">
			<label for="selectSuppliernr" class="mb-0">Leverandørnr</label>
			<input type="text" class="form-control form-control-sm" id="selectSuppliernr" size="8" maxlength="8">
		</div>
		<div class="form-group pr-2 col-1">
			<label for="selectAttkode" class="mb-0">Att.kode
				<select class="selectAttkode-data-ajax form-control form-control-sm" id="selectAttkode">
					<option value='${user.signatur}'>${user.signatur}</option>
				</select>
			</label>
		</div>
		<div class="form-group pr-2">
			<label for="selectKomment" class="mb-0">Kommentar</label>
			<input type="text" class="form-control form-control-sm" id="selectKomment" size="35" maxlength="35">
		</div>
		<div class="form-group pr-2">
			<label for="selectFradato" class="mb-0">Fra&nbsp;bilagsdato</label>
			<input type="text" class="form-control form-control-sm" id="selectFradato" size="8" maxlength="8">
		</div>
		<div class="form-group pr-2">
			<label for="selectFrapermnd" class="mb-0">Fra&nbsp;periode</label>
			<input type="text" class="form-control form-control-sm" id="selectFrapermnd" placeholder="mm" size="2" maxlength="2">
		</div>
		<div class="form-group pr-2">
			<label for="selectFraperaar" class="mb-0">&nbsp;</label>
			<input type="text" class="form-control form-control-sm" id="selectFraperaar" placeholder="yy" size="2" maxlength="2">
		</div>
		<div class="form-group pr-2">
			<label for="selectTilpermnd" class="mb-0">Til&nbsp;periode</label>
			<input type="text" class="form-control form-control-sm" id="selectTilpermnd"  placeholder="mm" size="2" maxlength="2">
		</div>
		<div class="form-group pr-2">
			<label for="selectTilperaar" class="mb-0">&nbsp;</label>
			<input type="text" class="form-control form-control-sm" id="selectTilperaar"  placeholder="yy" size="2" maxlength="2">
		</div>

	</div>

	<div class="form-row left-right-border">
		<div class="form-group pr-2 pl-1">
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
		<div class="form-group pr-2 pl-1">
			<label for="selectFrisokKode">Fri&nbsp;søkvei</label>
			<input type="text" class="form-control form-control-sm" placeholder="kode" id="selectFrisokKode" size="3" maxlength="3">
		</div>
		<div class="form-group pr-2 pl-1">
			<label for="selectFrisokTxt">&nbsp;</label>
			<input type="text" class="form-control form-control-sm" placeholder="tekst" id="selectFrisokTxt" size="15" maxlength="15">
		</div>

		<div class="form-group pr-2 pl-1">
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
		      <option value="" selected>-blank-</option>
		      <option value="*">Alle</option>
		      <option value="A">A</option>
		      <option value="B">B</option>
		      <option value="D">D</option>
		      <option value="G">G</option>
		      <option value="O">O</option>
		    </select>
		</div>

		<div class="form-group col-2 align-self-end">
			<div class="float-md-right">
				<button class="btn inputFormSubmit" onclick="loadKosta()" id="submitBtn"  autofocus>Søk</button>
			</div>
		</div>	
	
	
	</div>

	<div class="padded-row-small left-right-border no-gutters">&nbsp;</div>
	
	<div class="panel-body left-right-bottom-border no-gutters">
		<table class="table table-striped table-bordered table-hover" id="kostaTable">
			<thead class="tableHeaderField">
				<tr>
					<th>Innreg.nr</th>
					<th>Bilagsnr</th>
					<th>Fakturanr</th>
					<th>Bilagsdato</th>
					<th>Periode(mån)</th>
					<th>Periode(år)</th>
					<th>Leverandørnr</th>
					<th>Att.kode</th>
					<th>Kommentar</th>
					<th class="delete">Slett</th>					
				</tr>
			</thead>
		</table>
	</div>	
 
</div>

<!-- ======================= footer ===========================-->
<jsp:include page="/WEB-INF/views/footer.jsp" />
<!-- =====================end footer ==========================-->

