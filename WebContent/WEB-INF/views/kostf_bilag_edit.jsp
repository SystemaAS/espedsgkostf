<%@page pageEncoding="UTF-8" contentType="text/html; charset=UTF-8"%>
<%@ include file="/WEB-INF/views/include.jsp"%>

<!-- ======================= header ===========================-->
<jsp:include page="/WEB-INF/views/headerKostf.jsp" />
<!-- =====================end header ==========================-->

<link href="resources/espedsgkostf.css" rel="stylesheet" type="text/css"/>

<script type="text/javascript">
	"use strict";
	
	jq(document).ready(function() {
		//enable tooltip
 		jq('[data-toggle="tooltip"]').tooltip()
	});	
	
	
	
	
</script>

<div class="container-fluid">

	<div class="padded-row-small"></div>

	<nav>
		<div class="nav nav-tabs" id="nav-tab" role="tablist">
			<a class="nav-item nav-link" onClick="setBlockUI(this);" href="kostf_bilagslist.do">Bilager <img style="vertical-align: middle;" src="resources/images/list.gif">
			</a> <a class="nav-item nav-link active disabled">Bilag[${record.kabnr2}]</a>
		</div>
	</nav>

	<div class="padded-row-small left-right-border"></div>

	<form action="kostf_bilag_edit.do">

		<div class="form-group row left-right-bottom-border no-gutters">

			<div class="col-sm-6 formFrame">
				<div class="form-group form-row formFrameHeader">
					<div class="col-sm-12">
						<span class="rounded-top">&nbsp;</span>
					</div>
				</div>

				<div class="form-group form-row">
					<label for="bilagsserie" class="col-md-2 col-form-label col-form-label-sm">Bilagsserie:</label>
					<div class="col-md-1">
						<input type="text" class="form-control w-100" id="bilagsserie" value="TODO" placeholder="bilagsserie">
					</div>
					<div class="col-md-1">
						<a tabindex="-1" id="bilagsserie_Link">
							<img style="cursor:pointer;vertical-align: middle;" src="resources/images/find.png" width="14px" height="14px">
						</a>&nbsp;
					</div>

					<label for="bilagsnr" class="col-md-2 col-form-label col-form-label-sm">Bilagsnr:</label>
					<div class="col-md-6">
						<input type="number" class="form-control" id="bilagsnr" value="${record.kabnr2}" placeholder="bilagsnr">
					</div>

				</div>

				<div class="form-group form-row">
					<label for="bilagsnr" class="col-md-2 col-form-label col-form-label-sm">Bilagsdato:</label>
					<div class="col-md-10">
						<input type="number" class="form-control" id="bilagsnr" value="${record.kabdt}" placeholder="bilagsnr">
					</div>
				</div>

				<div class="form-group form-row">
					<label for="mnd" class="col-md-2 col-form-label col-form-label-sm">Period.(mån/år):</label>
					<div class="col-md-5">
						<input type="number" class="form-control w-25" id="mnd" value="${record.kapmn}" placeholder="mm">
						<input type="number" class="form-control w-25" id="aar" value="${record.KAPÅR}" placeholder="yy">
					</div>
				</div>

				<div class="form-group form-row">
					<label for="kommentar" class="col-md-2 col-form-label col-form-label-sm">Bilagskomm.:</label>
					<div class="col-md-9">
						<input type="text" class="form-control w-100" id="kommentar" value="${record.katxt}" placeholder="bilagskommentar">
					</div>
					<div class="col-md-1">
						<a tabindex="-1" id="kommentar_Link">
							<img style="cursor:pointer;vertical-align: middle;" src="resources/images/find.png" width="14px" height="14px">
						</a>&nbsp;
					</div>
				</div>

				<div class="form-group form-row">
					<label for="levnr" class="col-md-2 col-form-label col-form-label-sm">
						<img src="resources/images/info3.png" width="12px" height="12px" data-toggle="tooltip" title="(0=direkte i hovedbok)">
					Leverandörnr:
					</label>
					<div class="col-md-2">
						<input type="number" class="form-control w-100" id="levnr" value="${record.kalnr}" placeholder="levnr">
					</div>
					<div class="col-md-1">
						<a tabindex="-1" id="levnr_Link">
							<img style="cursor:pointer;vertical-align: middle;" src="resources/images/find.png" width="14px" height="14px">
						</a>&nbsp;
					</div>

					<div class="col-md-7">
						<input type="text" readonly class="form-control w-100" id="levnr" value="levname TODO">
					</div>

				</div>

				<div class="form-group form-row">
					<label for="gebyrkode" class="col-md-2 col-form-label col-form-label-sm">Gebyrkode.:</label>
					<div class="col-md-2">
						<input type="text" class="form-control w-100" id="gebyrkode" value="${record.kavk}" placeholder="kode">
					</div>
					<div class="col-md-1">
						<a tabindex="-1" id="gebyrkode_Link">
							<img style="cursor:pointer;vertical-align: middle;" src="resources/images/find.png" width="14px" height="14px">
						</a>&nbsp;
					</div>					
					
					<label for="belop" class="col-md-1 col-form-label col-form-label-sm">Belop.:</label>
					<div class="col-md-6">
						<input type="number" class="form-control" id="belop" value="${record.kabl}" placeholder="belop">
					</div>
				</div>

			</div>

			<div class="col-sm-6 formFrame">
				<div class="form-group form-row formFrameHeader">
					<div class="col-sm-12">
						<span class="rounded-top">&nbsp;</span>
					</div>
				</div>			
			
				<div class="form-group form-row">
					<label for="fakturanr" class="col-md-2 col-form-label col-form-label-sm">Fakturanr:</label>
					<div class="col-md-10">
						<input type="text" class="form-control" id="fakturanr" value="${record.kafnr}" placeholder="fakturanummer">
					</div>
				</div>

				<div class="form-group form-row">
					<label for="kid" class="col-md-2 col-form-label col-form-label-sm">KID:</label>
					<div class="col-md-10">
						<input type="number" class="form-control" id="kid" value="${record.kalkid}" placeholder="kid leverandorsfaktura">
					</div>
				</div>

				<div class="form-group form-row">
					<label for="attkode" class="col-md-2 col-form-label col-form-label-sm">Att.kode(signatur):</label>
					<div class="col-md-2">
						<input type="text" class="form-control w-50" id="attkode" value="${record.kasg}" placeholder="attenstasjonkode">
					</div>
					<div class="col-md-8">
						<a tabindex="-1" id="attkode_Link">
							<img style="cursor:pointer;vertical-align: middle;" src="resources/images/find.png" width="14px" height="14px">
						</a>&nbsp;
					</div>					

				</div>

				<div class="form-group form-row">
						<label for="betbet" class="col-md-2 col-form-label col-form-label-sm">Betal.betingelse:</label>
						<div class="col-md-10">
							<input type="number" class="form-control w-25" id="betbet" value="${record.kabb}" placeholder="betalingsbetingelse">
						</div>
				</div>

				<div class="form-group form-row">
						<label for="ffdato" class="col-md-2 col-form-label col-form-label-sm">Forfallsdato:</label>
						<div class="col-md-10">
							<input type="number" class="form-control" id="ffdato" value="${record.kaffdt}" placeholder="forfallsdato">
						</div>
				</div>
	
				<div class="form-group form-row">
					<label for="oppdatert_bruker" class="col-md-2 col-form-label col-form-label-sm">Sist&nbsp;oppdaterat:</label>
					<div class="col-md-10">
						<input type="text" readonly class="form-control" id="oppdatert_bruker" value="${record.kauser}">
						<input type="text" readonly class="form-control" id="oppdatert_dato" value="${record.opp_dato}">
					</div>
				</div>

				<div class="form-group form-row">
					<label for="regdato" class="col-md-2 col-form-label col-form-label-sm">Reg.dato:</label>
					<div class="col-md-10">
					<input type="text" readonly class="form-control" id="regdato" value="${record.reg_dato}">
					</div>
				</div>
	
			</div>


		</div>
		
		<div class="padded-row-small left-right-border no-gutters">&nbsp;</div>
		
		<div class="panel-body left-right-bottom-border no-gutters">
			<table class="table table-striped table-bordered table-hover" id="kostbTable">
				<thead class="tableHeaderField">
					<tr>
						<th>Op</th>
						<th>Avd.</th>
						<th>Opdnr</th>
						<th>Ot</th>
						<th>Fra</th>
						<th>Nø</th>
						<th>SK</th>
						<th>Kundenr</th>
						<th>Geb</th>
						<th>Val</th>
						<th>Beløp</th>
						<th>Mko</th>
						<th>Bel.til</th>
						<th>innt.MVA</th>
						<th>Vkt1</th>
						<th>Vkt2</th>
						<th>Ant</th>
						<th>Budsjett</th>
						<th>Diff%</th>
						<th>Gren</th>
						<th>Re</th>
						<th>At</th>
					</tr>
				</thead>
			</table>
		</div>	




	</form>

</div>

<!-- ======================= footer ===========================-->
<jsp:include page="/WEB-INF/views/footer.jsp" />
<!-- =====================end footer ==========================-->

