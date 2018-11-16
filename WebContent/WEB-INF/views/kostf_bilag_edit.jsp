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

		<div class="row left-right-border no-gutters">
			<div class="col-sm-6">
				<div class="form-group form-row formFrameHeader">
					<div class="col-sm-12">
						<span class="rounded-top">&nbsp;</span>
					</div>
				</div>

		<c:if test="${action == 1}"> <!-- CREATE -->
				<div class="form-group form-row">
					<label for="kttyp" class="col-md-2 col-form-label col-form-label-sm">Bilagsserie:</label>
					<div class="col-md-2">
						<select class="bilagsserie-data-ajax" style="width:100%">
							<option value="">-velg-</option>
						</select>
					</div>

					<label for="kabnr2" class="col-md-2 col-form-label col-form-label-sm">Bilagsnr:</label>
					<div class="col-md-6">
						<input type="number" class="form-control" name="kabnr2" id="kabnr2" value="${record.kabnr2}" placeholder="bilagsnr">
					</div>
				</div>
		</c:if>

		<c:if test="${action == 3}"> <!-- UPDATE -->
				<div class="form-group form-row">
					<label for="kabnr2" class="col-md-2 col-form-label col-form-label-sm">Bilagsnr:</label>
					<div class="col-md-8">
						<input type="number" class="form-control" name="kabnr2" id="kabnr2" value="${record.kabnr2}" placeholder="bilagsnr">
					</div>
				</div>
		</c:if>

				<div class="form-group form-row">
					<label for="kabdt" class="col-md-2 col-form-label col-form-label-sm">Bilagsdato:</label>
					<div class="col-md-10">
						<input type="number" class="form-control" name="bilagsnr" id="bilagsnr" value="${record.kabdt}" placeholder="bilagsdato">
					</div>
				</div>

				<div class="form-group form-row">
					<label for="kapmn" class="col-md-2 col-form-label col-form-label-sm">Period.(mån/år):</label>
					<div class="col-md-5">
						<input type="number" class="form-control w-25" name="kapmn" id="kapmn" value="${record.kapmn}" placeholder="mm">
						<input type="number" class="form-control w-25" name="KAPÅR" id="KAPÅR" value="${record.KAPÅR}" placeholder="yy">
					</div>
				</div>
	
				<div class="form-group form-row">
					<label for="katxt" class="col-md-2 col-form-label col-form-label-sm">Bilagskomm.:</label>
					<div class="col-md-9">
						<input type="text" class="form-control w-100" name="katxt" id="katxt" value="${record.katxt}" placeholder="bilagskommentar">
					</div>
					<div class="col-md-1">
						<a tabindex="-1" id="kommentar_Link">
							<img style="cursor:pointer;vertical-align: middle;" src="resources/images/find.png" width="14px" height="14px">
						</a>&nbsp;
					</div>
				</div>

				<div class="form-group form-row">
					<label for="kalnr" class="col-md-2 col-form-label col-form-label-sm">
						<img src="resources/images/info3.png" width="12px" height="12px" data-toggle="tooltip" title="(0=direkte i hovedbok)">
					Leverandörnr:
					</label>
					<div class="col-md-2">
						<input type="number" class="form-control w-100" name="kalnr" id="kalnr" value="${record.kalnr}" placeholder="levnr">
					</div>
					<div class="col-md-1">
						<a tabindex="-1" id="levnr_Link">
							<img style="cursor:pointer;vertical-align: middle;" src="resources/images/find.png" width="14px" height="14px">
						</a>&nbsp;
					</div>

					<div class="col-md-7">
						<input type="text" readonly class="form-control w-100" id="levname" value="levname TODO">
					</div>

				</div>

				<div class="form-group form-row">
					<label for="kavk" class="col-md-2 col-form-label col-form-label-sm">Gebyrkode.:</label>
					<div class="col-md-2">
						<input type="text" class="form-control w-100" name="kavk" id="kavk" value="${record.kavk}" placeholder="kode">
					</div>
					<div class="col-md-1">
						<a tabindex="-1" id="gebyrkode_Link">
							<img style="cursor:pointer;vertical-align: middle;" src="resources/images/find.png" width="14px" height="14px">
						</a>&nbsp;
					</div>					
					
					<label for="kabl" class="col-md-1 col-form-label col-form-label-sm">Belop.:</label>
					<div class="col-md-6">
						<input type="number" class="form-control" name="kabl" id="kabl" value="${record.kabl}" placeholder="belop">
					</div>
				</div>

			</div>

			<div class="col-sm-6">
				<div class="form-group form-row formFrameHeader">
					<div class="col-sm-12">
						<span class="rounded-top">&nbsp;</span>
					</div>
				</div>			
			
				<div class="form-group form-row">
					<label for="kafnr" class="col-md-2 col-form-label col-form-label-sm">Fakturanr:</label>
					<div class="col-md-10">
						<input type="text" class="form-control" name="kafnr" id="kafnr" value="${record.kafnr}" placeholder="fakturanummer">
					</div>
				</div>

				<div class="form-group form-row">
					<label for="kalkid" class="col-md-2 col-form-label col-form-label-sm">KID:</label>
					<div class="col-md-10">
						<input type="number" class="form-control" name="kalkid" id="kalkid" value="${record.kalkid}" placeholder="kid leverandorsfaktura">
					</div>
				</div>

				<div class="form-group form-row">
					<label for="kasg" class="col-md-2 col-form-label col-form-label-sm">Att.kode(signatur):</label>
					<div class="col-md-2">
						<input type="text" class="form-control w-50" name="kasg" id="kasg" value="${record.kasg}" placeholder="attenstasjonkode">
					</div>
					<div class="col-md-8">
						<a tabindex="-1" id="attkode_Link">
							<img style="cursor:pointer;vertical-align: middle;" src="resources/images/find.png" width="14px" height="14px">
						</a>&nbsp;
					</div>					

				</div>

				<div class="form-group form-row">
						<label for="kabb" class="col-md-2 col-form-label col-form-label-sm">Betal.betingelse:</label>
						<div class="col-md-10">
							<input type="number" class="form-control w-25" name="kabb" id="kabb" value="${record.kabb}" placeholder="betalingsbetingelse">
						</div>
				</div>

				<div class="form-group form-row">
						<label for="kaffdt" class="col-md-2 col-form-label col-form-label-sm">Forfallsdato:</label>
						<div class="col-md-10">
							<input type="number" class="form-control" name="kaffdt" id="kaffdt" value="${record.kaffdt}" placeholder="forfallsdato">
						</div>
				</div>
	
				<div class="form-group form-row">
					<label for="kauser" class="col-md-2 col-form-label col-form-label-sm">Sist&nbsp;oppdaterat:</label>
					<div class="col-md-10">
						<input type="text" readonly class="form-control" id="kauser" value="${record.kauser}">
						<input type="text" readonly class="form-control" id="oppdatert_dato" value="${record.opp_dato}">
					</div>
				</div>

				<div class="form-group form-row">
					<label for="reg_dato" class="col-md-2 col-form-label col-form-label-sm">Reg.dato:</label>
					<div class="col-md-10">
					<input type="text" readonly class="form-control" id="reg_dato" value="${record.reg_dato}">
					</div>
				</div>
	
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

<!-- ======================= footer ===========================-->
<jsp:include page="/WEB-INF/views/footer.jsp" />
<!-- =====================end footer ==========================-->

