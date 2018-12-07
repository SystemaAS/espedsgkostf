<!DOCTYPE html>
<%@page pageEncoding="UTF-8" contentType="text/html; charset=UTF-8"%>
<%@ include file="/WEB-INF/views/include.jsp" %>

<html>
	<head>
		<meta charset="utf-8">
	    <meta name="viewport" content="width=device-width, initial-scale=1, shrink-to-fit=no">
		
		<title>eSpedsg - <spring:message code="systema.kostf.title"/></title>

		<link href="https://cdnjs.cloudflare.com/ajax/libs/select2/4.0.6-rc.1/css/select2.min.css" rel="stylesheet" />
		<link href="/espedsg2/resources/${user.cssEspedsg}?ver=${user.versionEspedsg}" rel="stylesheet" type="text/css"/>
		<link href="resources/espedsgkostf.css" rel="stylesheet" type="text/css"/>
		<link type="text/css" href="//cdn.datatables.net/1.10.19/css/jquery.dataTables.css" rel="stylesheet"/>
		<link type="text/css" href="//ajax.googleapis.com/ajax/libs/jqueryui/1.11.4/themes/overcast/jquery-ui.css" rel="stylesheet"/>
 		<link rel="stylesheet" href="https://stackpath.bootstrapcdn.com/bootstrap/4.1.3/css/bootstrap.min.css">		
		<link rel="SHORTCUT ICON" type="image/png" href="resources/images/systema_logo.png"></link>
		<link rel="stylesheet" type="text/css" href="https://cdn.datatables.net/responsive/2.2.2/css/responsive.bootstrap4.css"/>
		<link rel="stylesheet" type="text/css" href="https://cdn.datatables.net/plug-ins/1.10.19/features/mark.js/datatables.mark.min.css"/>
		
		<script type="text/javascript" src="//ajax.googleapis.com/ajax/libs/jquery/1.12.4/jquery.min.js"></script>
		<script type="text/javascript" src="https://code.jquery.com/ui/1.12.1/jquery-ui.js"></script>
		<script type="text/javascript" src="https://cdnjs.cloudflare.com/ajax/libs/select2/4.0.6-rc.1/js/select2.min.js"></script>
		<script type="text/javascript" src="resources/js/jquery.blockUI.js"></script>
		<script type="text/javascript" src="/espedsg2/resources/js/systemaWebGlobal.js?ver=${user.versionEspedsg}"></script>
		<script type="text/javascript" src="//cdn.datatables.net/1.10.19/js/jquery.dataTables.min.js"></script>
		<script type="text/javascript" src="resources/js/espedsgkostf.js?ver=${user.versionEspedsg}"></script>	
		<script type="text/javascript" src="https://cdnjs.cloudflare.com/ajax/libs/popper.js/1.14.3/umd/popper.min.js"></script>
		<script type="text/javascript" src="https://stackpath.bootstrapcdn.com/bootstrap/4.1.3/js/bootstrap.min.js"></script>
		<script type="text/javascript" src="https://cdnjs.cloudflare.com/ajax/libs/underscore.js/1.8.3/underscore-min.js"></script>	
		<script type="text/javascript" src="https://cdn.datatables.net/responsive/2.2.2/js/dataTables.responsive.js"></script>
		<script type="text/javascript" src="https://cdn.jsdelivr.net/g/mark.js(jquery.mark.min.js)"></script>
		<script type="text/javascript" src="https://cdn.datatables.net/plug-ins/1.10.19/features/mark.js/datatables.mark.js"></script>
		
		<script>
			var lang = '${user.usrLang}';
			var kodtsfUrl = "/syjserviceskostf/syjsKODTSF?user=${user.user}";
			var levefUrl = "/syjserviceskostf/syjsLEVEF?user=${user.user}"
		</script>

	</head>
	
	
<div id="headerWrapper"> 
	<input type="hidden" name="language" id=language value="${user.usrLang}">
   <header> 
	   <div class="container-fluid"> 
			<div class="row headerTdsBannerAreaBg p-2">
			 	<div class="col-8">
					 <label class="text32Bold float-right" style="color:#778899;">eSpedsg-<spring:message code="systema.kostf.title"/></label>
				 </div>
				 <div class="col-4">
					<img class="img-fluid float-right" src="resources/images/systema_logo.png" width=80px height=50px>
				 </div>
			</div>

			<div class="row tabThinBorderLightGreenLogoutE2 align-items-center justify-content-end">
 				<div class="float-right">
    				<c:if test="${ empty user.usrLang || user.usrLang == 'NO'}">
	               		<img class="img-fluid" src="resources/images/countryFlags/Flag_NO.gif" height="12">
	               	</c:if>
	               	<c:if test="${ user.usrLang == 'DA'}">
	               		<img class="img-fluid" src="resources/images/countryFlags/Flag_DK.gif" height="12">
	               	</c:if>
	               	<c:if test="${ user.usrLang == 'SV'}">
	               		<img class="img-fluid" src="resources/images/countryFlags/Flag_SE.gif" height="12">
	               	</c:if>
	               	<c:if test="${ user.usrLang == 'EN'}">
	               		<img class="img-fluid" src="resources/images/countryFlags/Flag_UK.gif" height="12">
	               	</c:if>
 
					<span class="headerMenuGreenNoPointer">
						<img class="img-fluid" src="resources/images/appUser.gif">&nbsp;${user.user}&nbsp;${user.usrLang}			
					</span> 					
 	   				<font color="#FFFFFF" style="font-weight: bold;">&nbsp;&nbsp;|&nbsp;</font>
 					<span class="headerMenuGreenNoPointer">
						<a class="headerMenuGreen text14" tabindex=-1 href="logout.do">
							<img class="img-fluid" src="resources/images/home.gif">&nbsp;<spring:message code="dashboard.menu.button"/>		
						</a>
 					</span>
 				</div>
			</div>

	   </div> 
   </header>
   
</div>
</html>
	
