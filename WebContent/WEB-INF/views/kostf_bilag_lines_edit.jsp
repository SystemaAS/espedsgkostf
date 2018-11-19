<%@page pageEncoding="UTF-8" contentType="text/html; charset=UTF-8"%>
<%@ include file="/WEB-INF/views/include.jsp"%>

<!-- ======================= header ===========================-->
<jsp:include page="/WEB-INF/views/headerKostf.jsp" />
<!-- =====================end header ==========================-->

<link href="resources/espedsgkostf.css" rel="stylesheet" type="text/css"/>

<script type="text/javascript">
	"use strict";
	var kostbUrl = "/syjserviceskostf/syjsKOSTB?user=${user.user}";
	var kabnr = "${sessionParams.kabnr}";
	
	jq(document).ready(function() {

		loadKostb();
		
	});	
	
</script>

<div class="container-fluid">

	<div class="padded-row-small"></div>

	<nav>
		<div class="nav nav-tabs" id="nav-tab" role="tablist">
			<a class="nav-item nav-link" href="kostf_bilagslist.do">Bilager <img style="vertical-align: middle;" src="resources/images/list.gif"></a>
			<a class="nav-item nav-link" href="${bilagUrl_read}">Bilag[${sessionParams.kabnr}]</a>
			<a class="nav-item nav-link active disabled">Fordel kostnader[${sessionParams.kabnr}]</a>
			
		</div>
	</nav>

	<div class="padded-row-small left-right-border"></div>

	<form action="kostf_bilag_lines_edit.do">

		<div class="padded-row-small left-right-border no-gutters">&nbsp;</div>
		
		<div class="panel-body left-right-bottom-border no-gutters">
			<table class="display responsive" id="kostbTable">
				<thead class="tableHeaderField">
					<tr>
						<th>kbbnr</th>
						<th>kbavd</th>
						<th>kbopd</th>
					</tr>
				</thead>
			</table>
		</div>	

	</form>

</div>