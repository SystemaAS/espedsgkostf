<%@page pageEncoding="UTF-8" contentType="text/html; charset=UTF-8"%>
<%@ include file="/WEB-INF/views/include.jsp"%>

<!-- ======================= header ===========================-->
<jsp:include page="/WEB-INF/views/headerKostf.jsp" />
<!-- =====================end header ==========================-->

<link href="resources/espedsgkostf.css" rel="stylesheet" type="text/css"/>

<script type="text/javascript">
	"use strict";
	var signatur = "${user.signatur}";
	var attkode = "&attkode="+signatur;
	
	var kostaUrl = "/syjserviceskostf/syjsKOSTA?user=${user.user}";
	var levefUrl = "/syjserviceskostf/syjsLEVEF?user=${user.user}"
	var bilagUrl_read = "kostf_bilag_edit.do?user=${user.user}&action=2";
	var bilagUrl_delete = "kostf_bilag_edit.do?user=${user.user}&action=4";

	jq(document).ready(function() {

		initKostaSearch();
		
		jq('#selectAttkode').append('<option selected="true">${user.signatur}</option>');
		jq('#selectAttkode').prop('selectedIndex', '${user.signatur}');			
		
	});

</script>

<div class="container-fluid">

	<div class="padded-row-small"></div>	

	<nav>
	  <div class="nav nav-tabs" id="nav-tab" role="tablist">
	    <a class="nav-item nav-link active disabled">Bilager
			<img class="img-fluid float-center" src="resources/images/list.gif">
	    </a>
		<a class="nav-item nav-link nav-new" onClick="setBlockUI();" href="${bilagUrl_create}">Lage ny bilag</a>
		
	  </div>
	</nav>

	<div class="padded-row-small left-right-border"></div>	

	<div class="form-row left-right-border">
		<div class="form-group pr-2 pl-1 col-1">
			<label for="selectBilagsnr" class="col-form-label-sm mb-0">Bilagsnr</label>
			<input type="text" class="form-control form-control-sm" id="selectBilagsnr" size="8" maxlength="7">	
		</div>
		<div class="form-group pr-2 col-1">
			<label for="selectInnregnr" class="col-form-label-sm mb-0">Innreg.nr</label>
			<input type="text" class="form-control form-control-sm" id="selectInnregnr" size="8" maxlength="7"/>
		</div>
		<div class="form-group pr-2 col-1">
			<label for="selectFaktnr" class="col-form-label-sm mb-0">Fakturanr</label>
			<input type="text" class="form-control form-control-sm" id="selectFaktnr"  size="13"  maxlength="13">
		</div>

		<div class="form-group pr-2 col-1">
				<label for="selectSuppliernr" class="col-form-label-sm mb-0 mr-1">Lev.nr</label>
				<div class="input-group">
                    <input type="text" class="form-control form-control-sm" id="selectSuppliernr" size="8" maxlength="8">&nbsp;
                    <span class="input-group-prepend">
       					<a tabindex="-1" id="levnr_Link">
							<img src="resources/images/find.png" width="14px" height="14px">
						</a>
                    </span>
                </div>
		</div>

		<div class="form-group pr-2 col-1">
			<label for="selectAttkode" class="col-form-label-sm mb-0">Att.kode</label>
				<select class="form-control form-control-sm" id="selectAttkode"></select>
		</div>

		<div class="form-group pr-2 col-2">
			<label for="selectKomment" class="col-form-label-sm mb-0">Bilagskomm.</label>
			<input type="text" class="form-control form-control-sm" id="selectKomment" size="35" maxlength="35">
		</div>
		<div class="form-group pr-2 col-1">
			<label for="selectFradato" class="col-form-label-sm mb-0">Fra&nbsp;bilagsdato</label>
			<input type="text" class="form-control form-control-sm" id="selectFradato" size="8" maxlength="8">
		</div>

		<div class="form-group pr-2">
			<label for="selectFrapermnd" class="col-form-label-sm mb-0">Fra</label>
			<input type="text" class="form-control form-control-sm" id="selectFrapermnd" placeholder="mm" size="3" maxlength="2">
		</div>
		<div class="form-group pr-2">
			<label for="selectFraperaar" class="col-form-label-sm mb-0">&nbsp;</label>
			<input type="text" class="form-control form-control-sm" id="selectFraperaar" placeholder="yy" size="3" maxlength="2">
		</div>


		<div class="form-group pr-2">
			<label for="selectTilpermnd" class="col-form-label-sm mb-0">Til</label>
			<input type="text" class="form-control form-control-sm" id="selectTilpermnd"  placeholder="mm" size="3" maxlength="2">
		</div>
		<div class="form-group pr-2">
			<label for="selectTilperaar" class="col-form-label-sm mb-0">&nbsp;</label>
			<input type="text" class="form-control form-control-sm" id="selectTilperaar"  placeholder="yy" size="3" maxlength="2">
		</div>

	</div>

	<div class="form-row left-right-border">
		<div class="form-group pr-2 pl-1">
			<label for="selectReklamasjon" class="col-form-label-sm">
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
		    <select class="form-control form-control-sm" id="selectReklamasjon">
		      <option value="">-velg-</option>
		      <option value="S">S</option>
		      <option value="O">O</option>
		    </select>
		</div>
		<div class="form-group pr-2 pl-1">
			<label for="selectFrisokKode" class="col-form-label-sm">Fri&nbsp;søkvei</label>
			<input type="text" class="form-control form-control-sm" placeholder="kode" id="selectFrisokKode" size="3" maxlength="3">
		</div>
		<div class="form-group pr-2 pl-1">
			<label for="selectFrisokTxt" class="col-form-label-sm">&nbsp;</label>
			<input type="text" class="form-control form-control-sm" placeholder="tekst" id="selectFrisokTxt" size="15" maxlength="15">
		</div>

		<div class="form-group pr-2 pl-1">
			<label for="selectStatus" class="col-form-label-sm">
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
		    <select class="form-control form-control-sm" id="selectStatus">
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
				<button class="btn inputFormSubmit btn-sm" onclick="loadKosta()" id="submitBtn"  autofocus>Søk</button>
			</div>
		</div>	
	
	
	</div>

	<div class="padded-row-small left-right-border no-gutters">&nbsp;</div>

 	
	<div class="left-right-bottom-border no-gutters">
		<table class="display compact cell-border responsive nowrap" id="kostaTable">
			<thead class="tableHeaderField">
				<tr>
					<th>Innreg.nr</th>
					<th>Endre</th>
					<th>Bilagsnr</th>
					<th>Status</th>
					<th>P.(mn)</th>
					<th>P.(år)</th>
					<th>Fakt.nr</th>
					<th>Gebyr</th>
					<th>Lev.nr</th>
					<th>Leverandør</th>
					<th>Att.kode</th>
					<th>Bilagsdato</th>
					<th>Valuta</th>
					<th>Beløp</th>
					<th>Moms</th>
					<th>Bet.bet.</th>
					<th>Forfallsdato</th>
					<th>Kommentar</th>
					<th class="all">Slett</th>					
				</tr>
			</thead>
		</table>
	</div>	

</div>

