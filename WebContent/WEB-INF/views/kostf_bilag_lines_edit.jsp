<%@page pageEncoding="UTF-8" contentType="text/html; charset=UTF-8"%>
<%@ include file="/WEB-INF/views/include.jsp"%>

<!-- ======================= header ===========================-->
<jsp:include page="/WEB-INF/views/headerKostf.jsp" />
<!-- =====================end header ==========================-->

<link href="resources/espedsgkostf.css" rel="stylesheet" type="text/css"/>

<script type="text/javascript">
	"use strict";
	var kostbUrl = "/syjserviceskostf/syjsKOSTB?user=${user.user}";
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

	<div class="padded-row-small left-right-border"></div>

	<form action="kostf_bilag_lines_edit.do">

		<div class="padded-row-small left-right-border no-gutters">&nbsp;</div>
		
		<div class="panel-body left-right-bottom-border no-gutters">
			<table class="display compact cell-border responsive nowrap" id="kostbTable">
				<thead class="tableHeaderField">
					<tr>
						<th>Avd(kostb:kbavd)</th>
						<th>Opdnr(kostb:kbopd)</th>
						<th>Ot(?)</th>
						<th>Fra(?)</th>
						<th>Nø(kostb:kbnøkk)</th>
						<th>SK(?)</th>
						<th>Kundenr(kostb:kbkn)</th>
						<th>Geb(kostb:kbvk)</th>
						<th>Val(?)</th>
						<th>Beløp(kostb:kbblhb)</th>
						<th>Mko(kostb:kbkdm)</th>
						<th>Bel til innt.(kostb:kbbilt)</th>
						<th>MVA(kostb:kbkdmv)</th>
						<th>Vkt1(?)</th>
						<th>Vkt2(?)</th>
						<th>Ant(?)</th>
						<th>Budsjett(?)</th>
						<th>Diff%(?)</th>
						<th>Gren%(?)</th>
						<th>Re(?)</th>
						<th>At(?)</th>


					</tr>
				</thead>
			</table>
		</div>	

	</form>

</div>