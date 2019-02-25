<%@page pageEncoding="UTF-8" contentType="text/html; charset=UTF-8"%>
<%@ include file="/WEB-INF/views/include.jsp"%>

<!-- ======================= header ===========================-->
<jsp:include page="/WEB-INF/views/headerKostf.jsp" />
<!-- =====================end header ==========================-->

<link href="resources/espedsgkostf.css" rel="stylesheet" type="text/css"/>

<script type="text/javascript">
	"use strict";
 	var kabnr = "${kabnr}";

	jq(document).ready(function() {

		loadFriskk();
		
	});	
	
</script>


<div class="container-fluid">

	<div class="padded-row-small"></div>

	<nav>
		<div class="nav nav-tabs" id="nav-tab" role="tablist">
			<a class="nav-item nav-link" href="kostf_bilagslist.do">Bilager <img class="float-center" src="resources/images/list.gif"></a>
			<a class="nav-item nav-link img-bulletgreen" href="kostf_bilag_edit.do?action=2&kabnr=${kabnr}">&nbsp;&nbsp;Bilag[${kabnr}]</a>
			<a class="nav-item nav-link img-budget" href="kostf_bilag_lines_list.do?action=2&kabnr=${kabnr}">&nbsp;&nbsp;Fordel kostnader[${kabnr}]</a>
			<a class="nav-item nav-link active disabled img-lightbulb">&nbsp;&nbsp;Frie søkveier[${kabnr}]</a>
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
				<label for="kapmn" class="col-form-label-sm mb-0 ">Per.(mån&#47;år)</label>
				<div class="input-group">
					<label class="form-control-plaintext form-control-sm" id="kapmn"/>
					<label class="form-control-plaintext form-control-sm" id="KAPÅR"/>
				</div>
			</div>
			<div class="form-group pr-2 col-1">
				<label for="tilfordel" class="col-form-label-sm mb-0 pb-0">Til fordel</label>
				<label class="form-control-plaintext form-control-sm" id="tilfordel"/>
			</div>
			<div class="form-group pr-2 col-1">
				<label for="fordelt" class="col-form-label-sm mb-0 pb-0">Fordelt</label>
				<label class="form-control-plaintext form-control-sm" id="fordelt"/>
			</div>
			<div class="form-group pr-2 col-1">
				<label for="kast" class="col-form-label-sm mb-0 pb-0">Status</label>
				<label class="form-control-plaintext form-control-sm" id="kast"/>
			</div>
		</div>
		
	</div>

	<div class="panel-body left-right-border no-gutters">
		<table class="display compact cell-border responsive nowrap" id="friskkTable">
			<thead class="tableHeaderField">
				<tr>
					<th width="2%">Endre</th>
					<th>Kode</th>
					<th>Søketekst</th>
					<th>Dato</th>
					<th width="2%" class="all">Slett</th>					
				</tr>
			</thead>
		</table>
	</div>	

	<div class="form-row align-self-end left-right-border">
		<div class="float-md-left p-1">
			<button type="button" class="btn inputFormSubmitStd btn-sm" id="clear">Fjern verdier</button>
		</div>
	</div>

	<form action="kostf_bilag_frisok_edit.do" method="POST">
		<input type="hidden" name="action" id="action" value='${action}'>
		<input type="hidden" name="kbbnr" id="kbbnr" value='${kabnr}'>

		<div class="container-fluid p-1 left-right-border"> <!-- EDIT/NEW -->

			<div class="form-row left-right-border formFrameHeader">
				<div class="col-sm-12">
					<span class="rounded-top">&nbsp;Lage ny / endre</span>
					<img class="img-fluid float-center" src="resources/images/update.gif">
				</div>
			</div>

			<div class="form-row left-right-bottom-border formFrame">

				<div class="form-group pr-2 col-auto">
					<label for="fskode" class="col-form-label-sm mb-0 required">Kode</label>
					<div class="input-group">
						<input type="text" required class="form-control form-control-sm mr-1" name="fskode" id="fskode" value="${record.fskode}" size="4" maxlength="3">
							<span class="input-group-prepend">
								<a tabindex="-1" id="gebyrkode_Link">
									<img src="resources/images/find.png" width="14px" height="14px">
								</a>
							</span>
					</div>
				</div>
				<div class="form-group pr-2 col-auto">
					<label for="fssok" class="col-form-label-sm mb-0 required">Søketekst</label>
					<input type="text" required class="form-control form-control-sm" name="fssok" id="fssok" value="${record.fssok}" size="16" maxlength="15">
				</div>

				<div class="form-group col-11 align-self-end">
					<div class="float-md-right">
						<button class="btn inputFormSubmit btn-sm" id="submitBtn">Lagre</button>
					</div>
				</div>		

	
			</div> <!-- form-row -->

		</div> <!-- EDIT -->

	</form>

</div>