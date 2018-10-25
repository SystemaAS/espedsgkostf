<%@page pageEncoding="UTF-8" contentType="text/html; charset=UTF-8"%>
<%@ include file="/WEB-INF/views/include.jsp"%>

<!-- ======================= header ===========================-->
<jsp:include page="/WEB-INF/views/headerKostf.jsp" />
<!-- =====================end header ==========================-->

<link href="resources/espedsgkostf.css" rel="stylesheet" type="text/css"/>

<script type="text/javascript">
	"use strict";

	var baseUrl = "/syjserviceskostf/syjsKOSTA?user=${user.user}";
	var bilagLinesUrl_read = "kostf_bilag_lines_edit.do?user=${user.user}&action=2";	
	
	
</script>

<div class="container-fluid">

	<div class="padded-row-small"></div>

	<nav>
		<div class="nav nav-tabs" id="nav-tab" role="tablist">
			<a class="nav-item nav-link" onClick="setBlockUI(this);" href="kostf_bilagslist.do">Bilager <img style="vertical-align: middle;" src="resources/images/list.gif"></a>
			<a class="nav-item nav-link" href="kostf_bilag_lines_list.do">Bilag linjer[${record.kabnr}]</a>
			<a class="nav-item nav-link active disabled" href="kostf_bilag_lines_list.do">Fordel kostnader[${record.kabnr}]</a>
			
		</div>
	</nav>

	<div class="padded-row-small left-right-border"></div>

	<form action="kostf_bilag_lines_edit.do">

		<div class="padded-row-small left-right-border no-gutters">&nbsp;</div>
		
		<div class="panel-body left-right-bottom-border no-gutters">
			<table class="table table-striped table-bordered table-hover dt-responsive nowrap" id="kostbTable">
				<thead class="tableHeaderField">
					<tr>
						<th>1</th>
						<th>2</th>
						<th>3</th>
					</tr>
				</thead>
			</table>
		</div>	

	</form>

</div>

<!-- ======================= footer ===========================-->
<jsp:include page="/WEB-INF/views/footer.jsp" />
<!-- =====================end footer ==========================-->

