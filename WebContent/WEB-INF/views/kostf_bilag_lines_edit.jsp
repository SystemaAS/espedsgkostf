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
		<table class="display compact cell-border responsive nowrap" id="kostbTable">
			<thead class="tableHeaderField">
				<tr>
					<th>Avd</th>
					<th>Endre</th>
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
					<th class="all">Slett</th>					
				</tr>
			</thead>
		</table>
	</div>	

	<div class="form-row align-self-end left-right-border">
		<div class="float-md-left p-1">
			<button type="button" class="btn inputFormSubmitStd btn-sm" id="clear">Fjern verdier</button>
		</div>
	</div>

	<form action="kostf_bilag_lines_edit.do" method="POST">
		<input type="hidden" name="action" id="action" value='${action}'>
		<input type="hidden" name="kbbnr" id="kbbnr" value='${kabnr}'>

		<div class="container-fluid p-1 left-right-border"> <!-- EDIT/NEW -->

			<div class="form-row left-right-border formFrameHeader">
				<div class="col-sm-12">
					<span class="rounded-top">&nbsp;Lage ny / endre</span>
				</div>
			</div>

			<div class="form-row left-right-bottom-border formFrame">

				<input type="hidden" name="rrn" id="rrn" value="${record.rrn}">

				<div class="form-group pr-2 col-auto">
					<label for="kbblf" class="col-form-label-sm mb-0">Beløp,linje</label>
					<input autofocus type="text" class="form-control form-control-sm" name="kbblf" id="kbblf" value="${record.kbblf}" onKeyPress="return numberKey(event)"  size="16" maxlength="15">
				</div>
				<div class="form-group pr-2 col-auto">
					<label for="kbblhb" class="col-form-label-sm mb-0">Beløp,hovedbok</label>
					<input type="text" class="form-control form-control-sm" name="kbblhb" id="kbblhb" value="${record.kbblhb}" onKeyPress="return numberKey(event)"  size="16" maxlength="15">
				</div>
				<div class="form-group pr-2 col-auto">
					<label for="kbvk" class="col-form-label-sm mb-0">Gebyrkode</label>
					<div class="input-group">
						<input type="text" class="form-control form-control-sm mr-1" name="kbvk" id="kbvk" value="${record.kbvk}" size="4" maxlength="3">
							<span class="input-group-prepend">
								<a tabindex="-1" id="gebyrkode_Link">
									<img src="resources/images/find.png" width="14px" height="14px">
								</a>
							</span>
					</div>
				</div>
				<div class="form-group pr-2 col-auto">
					<label for="kbkdpf" class="col-form-label-sm mb-0">Plikt&#47;fri</label>
					<input type="text" class="form-control form-control-sm" name="kbkdpf" id="kbkdpf" value="${record.kbkdpf}" size="2" maxlength="1">
				</div>
				<div class="form-group pr-2 col-auto">
					<label for="kbkdmv" class="col-form-label-sm mb-0">Mva</label>
					<input type="text" class="form-control form-control-sm" name="kbkdmv" id="kbkdmv" value="${record.kbkdmv}" size="2" maxlength="1">
				</div>
				<div class="form-group pr-2 col-auto">
					<label for="kbkdm" class="col-form-label-sm mb-0">Momskode</label>
					<input type="text" class="form-control form-control-sm" name="kbkdm" id="kbkdm" value="${record.kbkdm}" onKeyPress="return numberKey(event)"  size="2" maxlength="1">
				</div>
				<div class="form-group pr-2 col-auto">
					<label for="kbkavd" class="col-form-label-sm mb-0">Fordel på avdeling</label>
					<input type="text" class="form-control form-control-sm" name="kbkavd" id="kbkavd" value="${record.kbkavd}" onKeyPress="return numberKey(event)"  size="5" maxlength="4">
				</div>
				<div class="form-group pr-2 col-auto">
					<label for="kbavd" class="col-form-label-sm mb-0">Avdeling</label>
					<input type="text" class="form-control form-control-sm" name="kbavd" id="kbavd" value="${record.kbavd}" onKeyPress="return numberKey(event)"  size="5" maxlength="4">
				</div>
				<div class="form-group pr-2 col-auto">
					<label for="kbopd" class="col-form-label-sm mb-0">Oppdragsnummer</label>
					<input type="text" class="form-control form-control-sm" name="kbopd" id="kbopd" value="${record.kbopd}" onKeyPress="return numberKey(event)"  size="6" maxlength="7">
				</div>
				<div class="form-group pr-2 col-auto">
					<label for="x" class="col-form-label-sm mb-0">Turnummer?</label>
					<input type="text" class="form-control form-control-sm" name="x" id="x" value="TODO" onKeyPress="return numberKey(event)"  size="6" maxlength="7">
				</div>
				<div class="form-group pr-2 col-auto">
					<label for="y" class="col-form-label-sm mb-0">Godsnummer?</label>
					<input type="text" class="form-control form-control-sm" name="y" id="z" value="TODO" onKeyPress="return numberKey(event)"  size="6" maxlength="7">
				</div>
				<div class="form-group pr-2 col-auto">
					<label for="kbpmn" class="col-form-label-sm mb-0 required">Per.(mån&#47;år)</label>
					<div class="input-group">
						<input type="text" required class="form-control form-control-sm mr-1" name="kbpmn" id="kbpmn" value="${record.kbpmn}" placeholder="mm" onKeyPress="return numberKey(event)" size="3" maxlength="2">
						<input type="text" required class="form-control form-control-sm" name="KBPÅR" id="KBPÅR" value="${record.KBPÅR}" placeholder="yy" onKeyPress="return numberKey(event)" size="3" maxlength="2">
					</div>
				</div>
				<div class="form-group pr-2 col-auto">
					<label for="z" class="col-form-label-sm mb-0">I&#47;O?</label>
					<input type="text" class="form-control form-control-sm" name="z" id="z" value="TODO" onKeyPress="return numberKey(event)"  size="6" maxlength="7">
				</div>
				<div class="form-group pr-2 col-auto">
					<label for="a" class="col-form-label-sm mb-0">Fran(*3)?</label>
					<input type="text" class="form-control form-control-sm" name="a" id="a" value="TODO" onKeyPress="return numberKey(event)"  size="6" maxlength="7">
				</div>
				<div class="form-group pr-2 col-auto">
					<label for="b" class="col-form-label-sm mb-0">I&#47;O?</label>
					<input type="text" class="form-control form-control-sm" name="b" id="b" value="TODO" onKeyPress="return numberKey(event)"  size="6" maxlength="7">
				</div>
				<div class="form-group pr-2 col-auto">
					<label for="c" class="col-form-label-sm mb-0">O.ty(*3)?</label>
					<input type="text" class="form-control form-control-sm" name="c" id="c" value="TODO" onKeyPress="return numberKey(event)"  size="6" maxlength="7">
				</div>
				<div class="form-group pr-2 col-auto">
					<label for="d" class="col-form-label-sm mb-0">I&#47;O?</label>
					<input type="text" class="form-control form-control-sm" name="d" id="d" value="TODO" onKeyPress="return numberKey(event)"  size="6" maxlength="7">
				</div>
				<div class="form-group pr-2 col-auto">
					<label for="e" class="col-form-label-sm mb-0">Part(*2)?</label>
					<input type="text" class="form-control form-control-sm" name="e" id="e" value="TODO" onKeyPress="return numberKey(event)"  size="6" maxlength="7">
				</div>
				<div class="form-group pr-2 col-auto">
					<label for="kbbilt" class="col-form-label-sm mb-0">Bilagstekst</label>
					<input type="text" class="form-control form-control-sm" name="kbbilt" id="kbbilt" value="${record.kbbilt}" size="16" maxlength="15">
				</div>
<!--  
				<div class="form-group pr-2 col-auto">
					<label for="kbbnr" class="col-form-label-sm mb-0">Bilagsnummer</label>
					<input type="text" class="form-control form-control-sm" name="kbbnr" id="kbbnr" value="${record.kbbnr}" onKeyPress="return numberKey(event)"  size="8" maxlength="7">
				</div>
-->
				<div class="form-group pr-2 col-auto">
					<label for="kbbuds" class="col-form-label-sm mb-0 required">Budsjett</label>
					<input type="text" required class="form-control form-control-sm" name="kbbuds" id="kbbuds" value="${record.kbbuds}" onKeyPress="return numberKey(event)"  size="16" maxlength="15">
				</div>

				<div class="form-group pr-2 col-auto">
					<label for="kbbval" class="col-form-label-sm mb-0">Budsjett valkod</label>
					<input type="text" class="form-control form-control-sm" name="kbbval" id="kbbval" value="${record.kbbval}" size="4" maxlength="3">
				</div>
				<div class="form-group pr-2 col-auto">
					<label for="kbfree" class="col-form-label-sm mb-0">Fritext</label>
					<input type="text" class="form-control form-control-sm" name="kbfree" id="kbfree" value="${record.kbfree}" size="38" maxlength="37">
				</div>
				<div class="form-group pr-2 col-auto">
					<label for="kbgeby" class="col-form-label-sm mb-0">Gebyr med&#47;u</label>
					<input type="text" class="form-control form-control-sm" name="kbgeby" id="kbgeby" value="${record.kbgeby}" onKeyPress="return numberKey(event)"  size="2" maxlength="1">
				</div>
				<div class="form-group pr-2 col-auto">
					<label for="kbgod" class="col-form-label-sm mb-0">Godkjent</label>
					<input type="text" class="form-control form-control-sm" name="kbgod" id="kbgod" value="${record.kbgod}" size="2" maxlength="1">
				</div>
				<div class="form-group pr-2 col-auto">
					<label for="kbkkey" class="col-form-label-sm mb-0">FORD.KEY OPD&#47;PRO&#47;GN(ej med?)</label>
					<input type="text" class="form-control form-control-sm" name="kbkkey" id="kbkkey" value="${record.kbkkey}" size="16" maxlength="15">
				</div>
				<div class="form-group pr-2 col-auto">
					<label for="kbkn" class="col-form-label-sm mb-0">Kundenr</label>
					<input type="text" class="form-control form-control-sm" name="kbkn" id="kbkn" value="${record.kbkn}" onKeyPress="return numberKey(event)"  size="9" maxlength="8">
				</div>
				<div class="form-group pr-2 col-auto">
					<label for="KBNØKK" class="col-form-label-sm mb-0">Konteringsmåte</label>
					<input type="text" class="form-control form-control-sm" name="KBNØKK" id="KBNØKK" value="${record.KBNØKK}" onKeyPress="return numberKey(event)"  size="2" maxlength="1">
				</div>
				<div class="form-group pr-2 col-auto">
					<label for="kbpcc" class="col-form-label-sm mb-0">PERIODE-ÅRHUNDRE(ej med?)</label>
					<input type="text" class="form-control form-control-sm" name="kbpcc" id="kbpcc" value="${record.kbpcc}" onKeyPress="return numberKey(event)"  size="3" maxlength="2">
				</div>
				<div class="form-group pr-2 col-auto">
					<label for="kbrefa" class="col-form-label-sm mb-0">Edi-motatt ref a</label>
					<input type="text" class="form-control form-control-sm" name="kbrefa" id="kbrefa" value="${record.kbrefa}" size="36" maxlength="35">
				</div>
				<div class="form-group pr-2 col-auto">
					<label for="kbrefb" class="col-form-label-sm mb-0">Edi-motatt ref a(b?)</label>
					<input type="text" class="form-control form-control-sm" name="kbrefb" id="kbrefb" value="${record.kbrefb}" size="36" maxlength="35">
				</div>
				<div class="form-group pr-2 col-auto">
					<label for="kbrefc" class="col-form-label-sm mb-0">Edi-motatt ref a(c?)</label>
					<input type="text" class="form-control form-control-sm" name="kbrefc" id="kbrefc" value="${record.kbrefc}" size="36" maxlength="35">
				</div>
				<div class="form-group pr-2 col-auto">
					<label for="kbrekl" class="col-form-label-sm mb-0">Reklamert status</label>
					<input type="text" class="form-control form-control-sm" name="kbrekl" id="kbrekl" value="${record.kbrekl}" size="3" maxlength="2">
				</div>
				<div class="form-group pr-2 col-auto">
					<label for="kbsg" class="col-form-label-sm mb-0">Att.kode&#47;signatur</label>
					<input type="text" class="form-control form-control-sm" name="kbsg" id="kbsg" value="${record.kbsg}" size="4" maxlength="3">
				</div>
				<div class="form-group pr-2 col-auto">
					<label for="kbsgg" class="col-form-label-sm mb-0">Godkjent&#47;signatur</label>
					<input type="text" class="form-control form-control-sm" name="kbsgg" id="kbsgg" value="${record.kbsgg}" size="4" maxlength="3">
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