<%@page pageEncoding="UTF-8" contentType="text/html; charset=UTF-8"%>
<%@ include file="/WEB-INF/views/include.jsp"%>

<!-- ======================= header ===========================-->
<jsp:include page="/WEB-INF/views/headerKostf.jsp" />
<!-- =====================end header ==========================-->

<link href="resources/espedsgkostf.css" rel="stylesheet" type="text/css"/>

<script type="text/javascript">
	"use strict";

	var kosttUrl = "/syjserviceskostf/syjsKOSTT?user=${user.user}";
	var levefUrlGet = "/syjserviceskostf/syjsLEVEF_GET?user=${user.user}"
	
	jq(document).ready(function() {
 		jq('[data-toggle="tooltip"]').tooltip(); //TODO?

		//default when NEW
 		jq('#kasg').append('<option selected="true">${user.signatur}</option>');
		jq('#kasg').prop('selectedIndex', '${user.signatur}');	
 	
 		getAttKode('#kasg');
		getBilagsSerie('#kttyp');
		
		
	});
</script>

<div class="container-fluid">

	<div class="padded-row-small"></div>

	<nav>
		<div class="nav nav-tabs" id="nav-tab" role="tablist">
			<a class="nav-item nav-link" onClick="setBlockUI(this);" href="kostf_bilagslist.do">Bilager <img style="vertical-align: middle;" src="resources/images/list.gif"></a>
			<a class="nav-item nav-link active disabled">Bilag[${record.kabnr}]</a>
			<c:if test="${action == 3}"> <!-- UPDATE -->
				<a class="nav-item nav-link" href="${bilagLinesUrl_read}">Fordel kostnader[${record.kabnr}]</a>
			</c:if>	
			<c:if test="${action == 3}"> <!-- UPDATE -->
				<a class="nav-item nav-link" href="${bilagFrisokUrl_read}">Frie søkveier[${record.kabnr}]</a>
			</c:if>	
		</div>
	</nav>

	<div class="padded-row-small left-right-border"></div>

	<div class="container-fluid p-1 left-right-border">

		<form action="kostf_bilag_edit.do" method="POST">
			<input type="hidden" name="action" id="action" value='${action}'>
		    <input type="hidden" name="kabnr" id="kabnr" value="${record.kabnr}">
	
			<div class="form-row left-right-border formFrameHeader">
				<div class="col-sm-12">
					<span class="rounded-top">&nbsp;</span>
				</div>
			</div>
	
			<div class="form-row left-right-bottom-border formFrame">
	
			 <c:if test="${action == 1}"> <!-- CREATE -->
					<div class="form-group pr-2">
						<label for="kttyp" class="col-form-label-sm mb-0">Bilagsserie</label>
						<select class="form-control form-control-sm w-auto" name="kttyp" id="kttyp">
							<option value="${record.kttyp}" selected>${record.kttyp}</option>	
						</select>
					</div>
					<div class="form-group pr-2 col-1">
						<label for="kabnr2" class="col-form-label-sm mb-0">Bilagsnr</label>
						<input type="text" autofocus class="form-control form-control-sm" name="kabnr2" id="kabnr2" value="${record.kabnr2}" onKeyPress="return numberKey(event)" size="8" maxlength="7">
					</div>
			 </c:if>
			 <c:if test="${action == 3}"> <!-- UPDATE -->
					<div class="form-group pr-2">
						<label for="kttyp" class="col-form-label-sm mb-0">Bilagsserie</label>
						<input tabindex="-1" type="text" readonly class="form-control form-control-sm w-auto" name="kttyp" id="kttyp" value="${record.kttyp}" size="2" maxlength="1">
					</div>
					<div class="form-group pr-2 col-1">
						<label for="kabnr2" class="col-form-label-sm mb-0">Bilagsnr</label>
						<input type="text" class="form-control form-control-sm" name="kabnr2" id="kabnr2" value="${record.kabnr2}" onKeyPress="return numberKey(event)" size="8" maxlength="7">
					</div>
	 		</c:if>
	
					<div class="form-group pr-2 col-1">
						<label for="kabdt" class="col-form-label-sm mb-0 required">Bilagsdato</label>
						<input type="text" required class="form-control form-control-sm" name="kabdt" id="kabdt" value="${record.kabdt}" onKeyPress="return numberKey(event)" size="8" maxlength="8">
					</div>
	
					<div class="form-group pr-2 col-1">
							<label for="kalnr" class="col-form-label-sm mb-0 mr-1">Lev.nr</label>
							<div class="input-group">
			                    <input type="text" class="form-control form-control-sm" name="kalnr" id="kalnr" value="${record.kalnr}" onKeyPress="return numberKey(event)" size="8" maxlength="8">&nbsp;
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
						<label for="kasg" class="col-form-label-sm mb-0 required">Att.kode</label>
						<select required class="form-control form-control-sm" name="kasg" id="kasg">
 					<c:if test="${action == 3}"> <!-- UPDATE -->
							<option value="${record.kasg}" selected>${record.kasg}</option>	
 					</c:if>
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
						<label for="kapmn" class="col-form-label-sm mb-0 required">Per.(mån&#47;år)</label>
						<div class="input-group">
							<input type="text" required class="form-control form-control-sm mr-1" name="kapmn" id="kapmn" value="${record.kapmn}" placeholder="mm" onKeyPress="return numberKey(event)" size="3" maxlength="2">
							<input type="text" required class="form-control form-control-sm" name="KAPÅR" id="KAPÅR" value="${record.KAPÅR}" placeholder="yy" onKeyPress="return numberKey(event)" size="3" maxlength="2">
						</div>
					</div>

					<div class="form-group pr-2 col-1">
						<label for="kavk" class="col-form-label-sm mb-0">Gebyrkode</label>
						<div class="input-group">
							<input type="text" class="form-control form-control-sm mr-1" name="kavk" id="kavk" value="${record.kavk}" size="4" maxlength="3">
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

					<div class="form-group pr-2 col-1">
						<label for="kablm" class="col-form-label-sm mb-0">Herav MVA</label>
						<input type="text" class="form-control form-control-sm" name="kablm" id="kablm" value="${record.kablm}" onKeyPress="return numberKey(event)"  size="14" maxlength="13">
					</div>

					<div class="form-group pr-2 col-1">
						<label for="kaval" class="col-form-label-sm mb-0 required">Valutakode</label>
						<div class="input-group">
							<input type="text" required class="form-control form-control-sm mr-1" name="kaval" id="kaval" value="${record.kaval}" size="4" maxlength="3">
								<span class="input-group-prepend">
									<a tabindex="-1" id="valutakode_Link">
										<img src="resources/images/find.png" width="14px" height="14px">
									</a>
								</span>
						</div>
					</div>

					<div class="form-group pr-2">
						<label for="kavku" class="col-form-label-sm mb-0">Kurs</label>
						<input type="text" class="form-control form-control-sm" name="kavku" id="kavku" value="${record.kavku}" onKeyPress="return amountKey(event)" size="8" maxlength="7">
					</div>

					<div class="form-group pr-2">
						<label for="kabb" class="col-form-label-sm mb-0">Bet.bet</label>
						<input type="text" class="form-control form-control-sm" name="kabb" id="kabb" value="${record.kabb}" onKeyPress="return numberKey(event)" size="3" maxlength="2">
					</div>
	
					<div class="form-group pr-2 col-1">
						<label for="kaffdt" class="col-form-label-sm mb-0">Forfallsdato</label>
						<input type="text" class="form-control form-control-sm" name="kaffdt" id="kaffdt" value="${record.kaffdt}" onKeyPress="return numberKey(event)" size="9" maxlength="8"/>
					</div>
	
					<div class="form-group pr-2 col-2">
						<label for="kafnr" class="col-form-label-sm mb-0 required">Fakturanr</label>
						<input type="text" required class="form-control form-control-sm" name="kafnr" id="kafnr"  size="14" maxlength="13" value="${record.kafnr}"/>
					</div>

					<div class="form-group pr-2 col-3">
						<label for="kalkid" class="col-form-label-sm mb-0">KID</label>
						<input type="text" class="form-control form-control-sm" name="kalkid" id="kalkid" value="${record.kalkid}" size="26" maxlength="25"/>
					</div>
	
					<div class="form-group pr-2">
						<label for="kaffdt" class="col-form-label-sm mb-0">Fakturadato
							<img class="img-fluid" onMouseOver="showPop('fdato_info');" onMouseOut="hidePop('fdato_info');"style="vertical-align:bottom;" width="12px" height="12px" src="resources/images/info3.png" alt="info">
						</label>
						<div class="text11" style="position: relative;" align="left">
							<span style="position:absolute; left:0px; top:0px; width:200px" id="fdato_info" class="popupWithInputText"  >
			         			<label>Blank = Bilagsdato</label>
							</span>
						</div>	
						<input type="text" class="form-control form-control-sm" name="kaffdt" id="kaffdt" value="${record.kaffdt}" onKeyPress="return numberKey(event)" size="9" maxlength="8"/>
					</div>	
	
					<div class="form-group pr-2 col-1">
						<label for="kast" class="col-form-label-sm mb-0">Status</label>
						<input type="text" class="form-control form-control-sm" name="kast" id="kast" value="${record.kast}" size="2" maxlength="1"/>
					</div>	
	
	
					<div class="form-group col-11 align-self-end">
						<div class="float-md-right">
							<button class="btn inputFormSubmit btn-sm" id="submitBtn">Lagre</button>
						</div>
					</div>					
					
			</div> <!-- form-row -->
			
		</form>
   	</div> <!-- container -->

	<!-- TODO remove when appropriate -->
<!--  
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

	</div>

-->

	<div class="form-row left-right-top-border">
			<div class="form-group pr-2 col-2">
				<label for="kauser" class="col-form-label-sm mb-0 pb-0">Sist&nbsp;oppdaterat</label>
				<label class="form-control-plaintext form-control-sm">${record.kauser}</label>
			</div>
			<div class="form-group pr-2 col-2">
				<label for="oppdatert_dato" class="col-form-label-sm mb-0 pb-0">Dato</label>
				<label class="form-control-plaintext form-control-sm" id="oppdatert_dato">${record.opp_dato}</label>
			</div>	
			<div class="form-group pr-2 col-2">
				<label for="reg_dato" class="col-form-label-sm mb-0 pb-0">Reg.dato&#47;tid</label>
				<label class="form-control-plaintext form-control-sm" id="reg_dato">${record.reg_dato}</label>
			</div>
	</div>

<c:if test="${not empty error}">
	<div class="container-fluid p-1 left-right-bottom-border">
		<div class="form-row no-gutters">

			<div class="alert alert-danger" role="alert">
				<p class="mb-0">${error}</p>
			</div>

		</div>
	</div>
</c:if>



</div> <!-- container -->