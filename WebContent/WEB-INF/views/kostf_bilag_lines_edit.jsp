<%@page pageEncoding="UTF-8" contentType="text/html; charset=UTF-8"%>
<%@ include file="/WEB-INF/views/include.jsp"%>

<!-- ======================= header ===========================-->
<jsp:include page="/WEB-INF/views/headerKostf.jsp" />
<!-- =====================end header ==========================-->

<link href="resources/espedsgkostf.css" rel="stylesheet" type="text/css"/>

<script type="text/javascript">
	"use strict";
// 	var kostbUrl = "/syjserviceskostf/syjsKOSTB_XTRA?user=${user.user}";
 	var kabnr = "${kabnr}";
	
	jq(document).ready(function() {

		loadKostb();
		
	});	
	
</script>

<div class="container-fluid">

	<div class="padded-row-small"></div>

	<nav>
		<div class="nav nav-tabs" id="nav-tab" role="tablist">
			<a class="nav-item nav-link" href="kostf_bilagslist.do">Bilager <img style="vertical-align: middle;" src="resources/images/list.gif"></a>
			<a class="nav-item nav-link" href="${bilagUrl_read}">Bilag[${kabnr}]</a>
			<a class="nav-item nav-link active disabled">Fordel kostnader[${kabnr}]</a>
			
		</div>
	</nav>


	<div class="container-fluid p-1 left-right-border">
		<div class="form-row">
				<div class="form-group pr-2 col-1">
					<label for="kabnr2" class="col-form-label-sm mb-0 pb-0">Bilagsnr</label>
					<label class="form-control-plaintext form-control-sm" id="kabnr2"/>
				</div>
				<div class="form-group pr-2 col-1">
					<label for="kabdt" class="col-form-label-sm mb-0 pb-0">Bilagsdato</label>
					<label class="form-control-plaintext form-control-sm" id="kabdt"/>
				</div>	
				<div class="form-group pr-2 col-1">
					<label for="kabnr" class="col-form-label-sm mb-0 pb-0">Innreg.nr</label>
					<label class="form-control-plaintext form-control-sm" id="kabnr"/>
				</div>
				<div class="form-group pr-2 col-1">
					<label for="kaval" class="col-form-label-sm mb-0 pb-0">Valuta</label>
					<label class="form-control-plaintext form-control-sm" id="kaval"/>
				</div>
				<div class="form-group pr-2 col-1">
					<label for="kalnr" class="col-form-label-sm mb-0 pb-0">Lev.nr</label>
					<label class="form-control-plaintext form-control-sm" id="kalnr"/>
				</div>
				<div class="form-group pr-2 col-2">
					<label for="levnavn" class="col-form-label-sm mb-0 pb-0">Lev.navn</label>
					<label class="form-control-plaintext form-control-sm" nowrap id="levnavn"/>
				</div>
				<div class="form-group pr-2 col-1">
					<label for="kapmn" class="col-form-label-sm mb-0 ">Per.(mån/år)</label>
					<div class="input-group">
						<label class="form-control-plaintext form-control-sm" id="kapmn"/>
						<label class="form-control-plaintext form-control-sm" id="KAPÅR"/>
					</div>
				</div>
		</div>
	</div>

	<form action="kostf_bilag_lines_edit.do">


		<div class="panel-body left-right-border no-gutters">
			<table class="display compact cell-border responsive nowrap" id="kostbTable">
				<thead class="tableHeaderField">
					<tr>
						<th>Avd</th>
						<th>Opdnr</th>
						<th>Ot</th>
						<th>Fra</th>
						<th>Nø</th>
						<th>SK(?)</th>
						<th>Kundenr</th>
						<th>Geb</th>
						<th>Val</th>
						<th>Beløp</th>
						<th>Mko</th>
						<th>Bel til innt.</th>
						<th>MVA</th>
						<th>Vkt1</th>
						<th>Vkt2(?)</th>
						<th>Ant</th>
						<th>Budsjett(algo?)</th>
						<th>Diff%(algo?)</th>
						<th>Gren%(algo?)</th>
						<th>Re</th>
						<th>At</th>

					</tr>
				</thead>
			</table>
		</div>	

		<div class="form-row left-right-top-border">

				<div class="form-group pr-2 col-2">
					<label for="kauser" class="col-form-label-sm mb-0 pb-0">x</label>
					<label class="form-control-plaintext form-control-sm"></label>
				</div>
				<div class="form-group pr-2 col-2">
					<label for="oppdatert_dato" class="col-form-label-sm mb-0 pb-0">y</label>
					<label class="form-control-plaintext form-control-sm" id="oppdatert_dato"></label>
				</div>	
				<div class="form-group pr-2 col-2">
					<label for="reg_dato" class="col-form-label-sm mb-0 pb-0">z</label>
					<label class="form-control-plaintext form-control-sm" id="reg_dato"></label>
				</div>

		</div>


	</form>

</div>