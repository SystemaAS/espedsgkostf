<%@page pageEncoding="UTF-8" contentType="text/html; charset=UTF-8"%>
<%@ include file="/WEB-INF/views/include.jsp"%>

<!-- ======================= header ===========================-->
<jsp:include page="/WEB-INF/views/headerKostf.jsp" />
<!-- =====================end header ==========================-->

<link href="resources/espedsgkostf.css" rel="stylesheet" type="text/css"/>

<script type="text/javascript">
	"use strict";
	var kosttUrl = "/syjserviceskostf/syjsKOSTT";
	
	jq(document).ready(function() {
 		jq('[data-toggle="tooltip"]').tooltip(); //TODO

 		jq.ajax({
 			  type: 'GET',
 			  url: kosttUrl,
 			  data: { user : '${user.user}'},
 			  dataType: 'json',
 			  cache: false,
 			  contentType: 'application/json',
 			  success: function(data) {
 			  	var len = data.length;
 			  	var i = 0;
 				var select_data = [];
 				_.each(data, function( d) {
 			  		select_data.push({
 			  	        id: d.kttyp,
 			  	        text: d.kttyp
 			  		});
 			  	 });
			  	
 			  	//Inject dropdown
 				jq('.bilagsserie-data-ajax').select2({
 					 data: select_data,
 					 language: "no",
 				})	
 				
 			  }, 
 			  error: function (jqXHR, exception) {
 				    alert('Error loading ...look in console log.');
 				    console.log(jqXHR);
 			  }	
 		});		
 		
		jq('.bilagsserie-data-ajax').change(function() {
			var selected = jq('.bilagsserie-data-ajax').select2('data');
			jq('#kttyp').val(selected[0].text);
		});
	
		

	});
</script>

<div class="container-fluid">

	<div class="padded-row-small"></div>

	<nav>
		<div class="nav nav-tabs" id="nav-tab" role="tablist">
			<a class="nav-item nav-link" onClick="setBlockUI(this);" href="kostf_bilagslist.do">Bilager <img style="vertical-align: middle;" src="resources/images/list.gif"></a>
			<a class="nav-item nav-link active disabled">Bilag[${sessionParams.kabnr}]</a>
			<c:if test="${action == 3}"> <!-- UPDATE -->
				<a class="nav-item nav-link" href="${bilagLinesUrl_read}">Fordel kostnader[${sessionParams.kabnr}]</a>
			</c:if>	
		</div>
	</nav>

	<div class="padded-row-small left-right-border"></div>

	<form action="kostf_bilag_edit.do" method="POST">

		<input type="hidden" name="action" id="action" value='${action}'>
	    <input type="hidden" name="kabnr" id="kabnr" value='${sessionParams.kabnr}'>
	    <input type="hidden" name="kttyp" id="kttyp" value='${record.kttyp}'>

		<div class="form-row left-right-border">
		<c:if test="${action == 1}"> <!-- CREATE -->
				<div class="form-group pr-2 col-1">
					<label for="kttyp" class="col-form-label-sm mb-0">Att.kode</label>
						<select class="bilagsserie-data-ajax form-control form-control-sm" id="kttyp">
							<option value="">-velg-</option>
						</select>
				</div>

				<div class="form-group pr-2 pl-1">
					<label for="kabnr2" class="col-form-label-sm mb-0">Bilagsnr</label>
					<input type="text" class="form-control form-control-sm" id="kabnr2" size="8" maxlength="7">	
				</div>				
				
		</c:if>
		<c:if test="${action == 3}"> <!-- UPDATE -->
				<div class="form-group">
					<label for="kabnr2" class="col-form-label-sm">Bilagsnr</label>
						<input type="number" class="form-control form-control-sm" name="kabnr2" id="kabnr2" value="${record.kabnr2}">
				</div>
		</c:if>

				<div class="form-group pr-2">
					<label for="kabdt" class="col-form-label-sm mb-0">Bilagsdato</label>
					<input type="text" class="form-control form-control-sm" id="kabdt" size="8" maxlength="8">
				</div>

				<div class="form-group pr-2">
					<label for="kapmn" class="col-form-label-sm">Period.(mån/år)</label>
						<input type="number" class="form-control form-control-sm" name="kapmn" id="kapmn" value="${record.kapmn}" placeholder="mm" size="3" maxlength="2">
						<input type="number" class="form-control form-control-sm" name="KAPÅR" id="KAPÅR" value="${record.KAPÅR}" placeholder="yy" size="3" maxlength="2">
				</div>
	
				<div class="form-group">
					<label for="katxt" class="col-form-label-sm">Bilagskomm.:</label>
						<input type="text" class="form-control w-100" name="katxt" id="katxt" value="${record.katxt}" placeholder="bilagskommentar">
						<a tabindex="-1" id="kommentar_Link">
							<img style="cursor:pointer;vertical-align: middle;" src="resources/images/find.png" width="14px" height="14px">
						</a>&nbsp;
				</div>

				<div class="form-group">
					<label for="kalnr" class="col-form-label-sm">
						<img src="resources/images/info3.png" width="12px" height="12px" data-toggle="tooltip" title="(0=direkte i hovedbok)">
					Leverandörnr:
					</label>
						<input type="number" class="form-control w-100" name="kalnr" id="kalnr" value="${record.kalnr}" placeholder="levnr">
						<a tabindex="-1" id="levnr_Link">
							<img style="cursor:pointer;vertical-align: middle;" src="resources/images/find.png" width="14px" height="14px">
						</a>&nbsp;

						<input type="text" readonly class="form-control w-100" id="levnavn" value="${record.levnavn}">

				</div>

				<div class="form-group">
					<label for="kavk" class="col-form-label-sm">Gebyrkode.:</label>
						<input type="text" class="form-control w-100" name="kavk" id="kavk" value="${record.kavk}" placeholder="kode">
						<a tabindex="-1" id="gebyrkode_Link">
							<img style="cursor:pointer;vertical-align: middle;" src="resources/images/find.png" width="14px" height="14px">
						</a>&nbsp;
					
					<label for="kabl" class="col-form-label-sm">Belop.:</label>
						<input type="number" class="form-control" name="kabl" id="kabl" value="${record.kabl}">
				</div>

				<div class="form-group">
					<label for="kafnr" class="col-form-label-sm">Fakturanr:</label>
						<input type="text" class="form-control" name="kafnr" id="kafnr" value="${record.kafnr}">
				</div>

				<div class="form-group">
					<label for="kalkid" class="col-form-label-sm">KID:</label>
						<input type="number" class="form-control" name="kalkid" id="kalkid" value="${record.kalkid}">
				</div>

				<div class="form-group">
					<label for="kasg" class="col-form-label-sm">Att.kode(signatur):</label>
						<input type="text" class="form-control w-50" name="kasg" id="kasg" value="${record.kasg}">
						<a tabindex="-1" id="attkode_Link">
							<img style="cursor:pointer;vertical-align: middle;" src="resources/images/find.png" width="14px" height="14px">
						</a>&nbsp;

				</div>

				<div class="form-group">
						<label for="kabb" class="col-form-label-sm">Betal.betingelse:</label>
							<input type="number" class="form-control w-25" name="kabb" id="kabb" value="${record.kabb}">
				</div>

				<div class="form-group">
						<label for="kaffdt" class="col-form-label-sm">Forfallsdato:</label>
							<input type="number" class="form-control" name="kaffdt" id="kaffdt" value="${record.kaffdt}">
				</div>
	
				<div class="form-group">
					<label for="kauser" class="col-form-label-sm">Sist&nbsp;oppdaterat:</label>
						<input type="text" readonly class="form-control" id="kauser" value="${record.kauser}">
						<input type="text" readonly class="form-control" id="oppdatert_dato" value="${record.opp_dato}">
				</div>

				<div class="form-group">
					<label for="reg_dato" class="col-form-label-sm">Reg.dato:</label>
					<input type="text" readonly class="form-control" id="reg_dato" value="${record.reg_dato}">
				</div>
		</div>

		<div class="padded-row-small left-right-border"></div>	

		
		<div class="form-group form-row left-right-border">
			<div class="col-md-11">&nbsp;</div>
			<div class="col-md-1">
				<button class="btn inputFormSubmit" id="submitBtnLagre">Lagre</button>
			</div>	
		</div>

		<div class="padded-row-small left-right-bottom-border"></div>	
		
</form>

</div>