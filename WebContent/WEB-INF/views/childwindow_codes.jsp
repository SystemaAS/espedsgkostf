<%@page pageEncoding="UTF-8" contentType="text/html; charset=UTF-8"%>
<%@ include file="/WEB-INF/views/include.jsp"%>

<SCRIPT type="text/javascript" src="resources/js/childwindow_codes.js?ver=${user.versionEspedsg}"></SCRIPT>

<table width="90%" height="500px"
	class="tableBorderWithRoundCorners3D_RoundOnlyOnBottom" cellspacing="0"
	border="0" cellpadding="0">
	<tr>
		<td colspan="3" class="text14Bold">&nbsp;&nbsp;&nbsp; <img
			title="search" valign="bottom" src="resources/images/search.gif"
			width="24px" height="24px" border="0" alt="search"> 
				<spring:message code="systema.main.maintenance.search"/>
		</td>
	</tr>
	<tr>
		<td valign="top">
			<%-- this container table is necessary in order to separate the datatables element and the frame above, otherwise
			 	the cosmetic frame will not follow the whole datatable grid including the search field... --%>
			<table id="containerdatatableTable" cellspacing="2" align="left" width="100%">
				<tr height="10">
					<td></td>
				</tr>
				<tr class="text12">
					<td class="ownScrollableSubWindowDynamicWidthHeight" width="100%"
						style="height: 30em;">
						<%-- this is the datatables grid (content)--%>
						<table id="codeList" class="display compact cell-border" width="100%">
							<thead>
								<tr style="background-color: #EEEEEE">
									<th class="text14">&nbsp;
										<spring:message code="systema.main.maintenance.main.gate.code"/>
									&nbsp;</th>
									<th class="text14">&nbsp;
										<spring:message code="systema.main.maintenance.main.gate.description"/>
									&nbsp;</th>
								</tr>
							</thead>
							<tbody>
								<c:forEach var="record" items="${model.codeList}"
									varStatus="counter">
									<c:choose>
										<c:when test="${counter.count%2==0}">
											<tr class="text14">
										</c:when>
										<c:otherwise>
											<tr class="text14">
										</c:otherwise>
									</c:choose>

									<td nowrap style="cursor: pointer;" class="text14MediumBlue"
										id="code${record.code}@description${record.description}@caller${model.caller}">&nbsp;<img
										title="select" valign="bottom"
										src="resources/images/update.gif" border="0" alt="edit">
										&nbsp;&nbsp;${record.code}
									</td>
									<td class="text14">&nbsp;${record.description}</td>
								</c:forEach>
							</tbody>
						</table>
					</td>
				</tr>
			</table>
		</td>
	</tr>
</table>
