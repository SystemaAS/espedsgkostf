<%@page pageEncoding="UTF-8" contentType="text/html; charset=UTF-8"%>
<%@ include file="/WEB-INF/views/include.jsp"%>

<!-- ======================= header ===========================-->
<jsp:include page="/WEB-INF/views/headerKostf.jsp" />
<!-- =====================end header ==========================-->

<link href="resources/espedsgkostf.css" rel="stylesheet" type="text/css"/>

<script type="text/javascript">
	"use strict";
	var kostaUrl = "/syjserviceskostf/syjsKOSTA?user=${user.user}";
	var bilagUrl_read = "kostf_bilag_edit.do?user=${user.user}&action=2";
	var bilagUrl_delete = "kostf_bilag_edit.do?user=${user.user}&action=4";

	jq(document).ready(function() {
		//init search, with signatur
		jq("#selectAttkode").val('${user.signatur}');
		jq("#submitBtn").click();
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

	<div class="row left-right-border no-gutters">
		<div class="col-1 p-1">
			<label for="selectBilagsnr">Bilagsnr</label>
			<br>
			<input type="text" class="form-control" id="selectBilagsnr" size="8" maxlength="7">	
		</div>
		<div class="col-1 p-1">
			<label for="selectInnregnr">Innreg.nr</label>
			<br>
			<input type="text" class="form-control" id="selectInnregnr" size="8" maxlength="6"/>
		</div>
		<div class="col-1 p-1">
			<label for="selectFaktnr">Fakturanr</label>
			<br>
			<input type="text" class="form-control" id="selectFaktnr" size="14" maxlength="13">
		</div>
		<div class="col-1 p-1">
			<label for="selectSuppliernr">Leverandørnr</label>
			<br>
			<input type="text" class="form-control" id="selectSuppliernr" size="9" maxlength="8">
		</div>
		<div class="col-1 p-1">
			<label for="selectAttkode">Att.kode</label>
			<br>
			<input type="text" class="form-control" id="selectAttkode" size="4" maxlength="3">
		</div>
		<div class="col-2 p-1">
			<label for="selectKomment">Kommentar</label>
			<br>
			<input type="text" class="form-control" id="selectKomment" size="36" maxlength="35">
		</div>
		<div class="col-1 p-1">
			<label for="selectFradato">Fra&nbsp;bilagsdato</label>
			<br>
			<input type="text" class="form-control" id="selectFradato" size="9" maxlength="8">
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
			<button class="btn inputFormSubmit" onclick="loadKosta()" id="submitBtn"  autofocus>Søk</button>
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

