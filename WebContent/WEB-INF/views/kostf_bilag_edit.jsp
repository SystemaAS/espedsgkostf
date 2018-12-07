<%@page pageEncoding="UTF-8" contentType="text/html; charset=UTF-8"%>
<%@ include file="/WEB-INF/views/include.jsp"%>

<!-- ======================= header ===========================-->
<jsp:include page="/WEB-INF/views/headerKostf.jsp" />
<!-- =====================end header ==========================-->

<link href="resources/espedsgkostf.css" rel="stylesheet" type="text/css"/>

<script type="text/javascript">
	"use strict";
	var kosttUrl = "/syjserviceskostf/syjsKOSTT";
	var levefUrlGet = "/syjserviceskostf/syjsLEVEF_GET?user=${user.user}"
	
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
 				    alert('Error loading kosttUrl...look in console log.');
 				    console.log(jqXHR);
 			  }	
 		});		
 		
		jq('.bilagsserie-data-ajax').change(function() {
			var selected = jq('.bilagsserie-data-ajax').select2('data');
			jq('#kttyp').val(selected[0].text);
		});
	
		getAttKode('#kasg');

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

	<div class="container-fluid p-1 left-right-border">

		<form action="kostf_bilag_edit.do" method="POST">
			<input type="hidden" name="action" id="action" value='${action}'>
		    <input type="hidden" name="kabnr" id="kabnr" value='${sessionParams.kabnr}'>
		    <input type="hidden" name="kttyp" id="kttyp" value='${record.kttyp}'>
	
			<div class="form-row left-right-border formFrameHeader">
				<div class="col-sm-12">
					<span class="rounded-top">&nbsp;</span>
				</div>
			</div>
	
			<div class="form-row left-right-bottom-border formFrame">
	
			 <c:if test="${action == 1}"> <!-- CREATE -->
					<div class="form-group pr-2 col-1">
						<label for="kttyp" class="col-form-label-sm mb-0">Bilagsserie</label>
							<select class="bilagsserie-data-ajax form-control form-control-sm" id="kttyp">
								<option value="">-velg-</option>
							</select>
					</div>
			 </c:if>
			 <c:if test="${action == 3}"> <!-- UPDATE -->
					<div class="form-group pr-2 col-1">
						<label for="kabnr2" class="col-form-label-sm mb-0">Bilagsnr</label>
						<input type="text" class="form-control form-control-sm" name="kabnr2" id="kabnr2" value="${record.kabnr2}" onKeyPress="return numberKey(event)" size="8" maxlength="7">
					</div>
			 </c:if>
	
					<div class="form-group pr-2 col-1">
							<label for="kalnr" class="col-form-label-sm mb-0 mr-1">Lev.nr</label>
							<div class="input-group">
			                    <input type="text" class="form-control form-control-sm" id="kalnr" value="${record.kalnr}" onKeyPress="return numberKey(event)" size="8" maxlength="8">&nbsp;
			                    <span class="input-group-prepend">
			       					<a tabindex="-1" id="levnr_Link2">
										<img src="resources/images/find.png" width="14px" height="14px">
									</a>
			                    </span>
			                </div>
					</div>
	
					<div class="form-group pr-2 pl-1 col-2">
						<label for="levnavn" class="col-form-label-sm mb-0">Lev.navn</label>
						<input tabindex="-1" type="text" readonly class="form-control form-control-sm" name="levnavn" id="levnavn" value="${record.levnavn}">
					</div>	
	
					<div class="form-group pr-2">
						<label for="kasg" class="col-form-label-sm mb-0">Att.kode</label>
							<select class="form-control form-control-sm" name="kasg" id="kasg">
								<option value="${record.kasg}" selected>${record.kasg}</option>	
							</select>
					</div>
	
					<div class="form-group pr-2 col-2">
						<label for="katxt" class="col-form-label-sm mb-0 mr-1">Bilagskomm.</label>
						<div class="input-group">
							<input type="text" class="form-control form-control-sm mr-1" name="katxt" id="katxt" value="${record.katxt}" size="35" maxlength="35">
							 <span class="input-group-prepend">
								<a tabindex="-1" id="kommentar_Link">
										<img src="resources/images/find.png" width="14px" height="14px">
								</a>
							</span>
						</div>
					</div>
	
					<div class="form-group pr-2 col-1">
						<label for="kabdt" class="col-form-label-sm mb-0">Bilagsdato</label>
						<input type="text" required class="form-control form-control-sm" name="kabdt" id="kabdt" value="${record.kabdt}" onKeyPress="return numberKey(event)" size="8" maxlength="8">
					</div>
	
					<div class="form-group pr-2 col-1">
						<label for="kapmn" class="col-form-label-sm mb-0 required">Per.(mån/år)</label>
						<div class="input-group">
							<input type="text" required class="form-control form-control-sm mr-1" name="kapmn" id="kapmn" value="${record.kapmn}" placeholder="mm" onKeyPress="return numberKey(event)" size="3" maxlength="2">
							<input type="text" required class="form-control form-control-sm" name="KAPÅR" id="KAPÅR" value="${record.KAPÅR}" placeholder="yy" onKeyPress="return numberKey(event)" size="3" maxlength="2">
						</div>
					</div>
		
					<div class="form-group pr-2 col-1">
						<label for="kavk" class="col-form-label-sm mb-0 required">Gebyrkode</label>
						<div class="input-group">
							<input type="text" required class="form-control form-control-sm mr-1" name="kavk" id="kavk" value="${record.kavk}">
								<span class="input-group-prepend">
									<a tabindex="-1" id="gebyrkode_Link">
										<img src="resources/images/find.png" width="14px" height="14px">
									</a>
								</span>
						</div>
					</div>
	
					<div class="form-group pr-2 col-1">
						<label for="kabl" class="col-form-label-sm mb-0 required">Beløp</label>
						<input type="text" required class="form-control form-control-sm" name="kabl" id="kabl" value="${record.kabl}" onKeyPress="return numberKey(event)"  size="14" maxlength="13">
					</div>
	
					<div class="form-group pr-2">
						<label for="kamva" class="col-form-label-sm mb-0">Mva</label>
							<select class="form-control form-control-sm" name="kamva" id="kamva">
			  					<option value="">-velg-</option>
			  					<option value="P"<c:if test="${record.kamva == 'P'}"> selected </c:if>>P</option>
			  					<option value="F"<c:if test="${record.kamva == 'F'}"> selected </c:if>>F</option>
							</select>						
					</div>
	
					<div class="form-group pr-2">
						<label for="kabb" class="col-form-label-sm mb-0">Bet.bet</label>
						<input type="text" tabindex="-1" readonly class="form-control form-control-sm" name="kabb" id="kabb" value="${record.kabb}" size="3" maxlength="2">
					</div>
	
					<div class="form-group pr-2 col-1">
						<label for="kaffdt" class="col-form-label-sm mb-0">Forfallsdato</label>
						<input type="text" tabindex="-1" readonly class="form-control form-control-sm" name="kaffdt" id="kaffdt" value="${record.kaffdt}" onKeyPress="return numberKey(event)" size="9" maxlength="8"/>
					</div>
	
					
					<div class="form-group col-2 align-self-end">
						<div class="float-md-right">
							<button class="btn inputFormSubmit btn-sm" id="submitBtn"  autofocus>Lagre</button>
						</div>
					</div>					
					
			</div> <!-- form-row -->
			
		</form>
   	</div> <!-- container -->

	<div class="container-fluid p-1 left-right-border">
		<form>	
			<fieldset <c:if test="${action == 3}"> disabled</c:if>>
				<div class="form-row left-right-top-border">

					<div class="form-group pr-2 col-2">
						<label for="kafnr" class="col-form-label-sm mb-0">Fakturanr</label>
						<input type="text" class="form-control form-control-sm" name="kafnr" id="kafnr"  size="14" maxlength="13" value="${record.kafnr}"/>
					</div>

					<div class="form-group pr-2 col-3">
						<label for="kalkid" class="col-form-label-sm mb-0">KID</label>
						<input type="text" class="form-control form-control-sm" name="kalkid" id="kalkid" value="${record.kalkid}" size="26" maxlength="25"/>
					</div>
	
					<div class="form-group pr-2 col-1">
						<label for="kafdt" class="col-form-label-sm mb-0 required">Fakturadato</label>
						<input type="text" required class="form-control form-control-sm" name="kafdt" id="kafdt" value="${record.kafdt}" onKeyPress="return numberKey(event)" size="9" maxlength="8"/>
					</div>	
	
				</div>
			</fieldset>
		</form>
	
	</div> <!-- container -->

	<div class="container-fluid p-1 left-right-border">
		<div class="form-row left-right-top-border">

				<div class="form-group pr-2 col-1">
					<label for="kauser" class="col-form-label-sm mb-0">Sist&nbsp;oppdaterat</label>
					 <p class="form-control-sm form-control-static" id="kauser">${record.kauser}</p>
				</div>
				<div class="form-group pr-2 col-1">
					<label for="oppdatert_dato" class="col-form-label-sm mb-0">&nbsp;</label>
					 <p class="form-control-sm form-control-static" id="oppdatert_dato">${record.opp_dato}</p>
				</div>	

				<div class="form-group pr-2 col-1">
					<label for="reg_dato" class="col-form-label-sm mb-0">Reg.dato</label>
					<p class="form-control-sm form-control-static" id="reg_dato">${record.reg_dato}</p>
				</div>

		</div>
	</div>


	<div class="padded-row-small left-right-bottom-border"></div>	



</div> <!-- container -->