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

	</head>
	
	
<div id="headerWrapper"> 
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

			<div class="row tabThinBorderLightGreenLogoutE2">
				<div class="col-8"></div>
 				<div class="col-4">
    				<c:if test="${ empty user.usrLang || user.usrLang == 'NO'}">
	               		<img src="resources/images/countryFlags/Flag_NO.gif" height="12" border="0" alt="country">
	               	</c:if>
	               	<c:if test="${ user.usrLang == 'DA'}">
	               		<img src="resources/images/countryFlags/Flag_DK.gif" height="12" border="0" alt="country">
	               	</c:if>
	               	<c:if test="${ user.usrLang == 'SV'}">
	               		<img src="resources/images/countryFlags/Flag_SE.gif" height="12" border="0" alt="country">
	               	</c:if>
	               	<c:if test="${ user.usrLang == 'EN'}">
	               		<img src="resources/images/countryFlags/Flag_UK.gif" height="12" border="0" alt="country">
	               	</c:if>
      				&nbsp;
      				<font class="headerMenuGreenNoPointer">
	    				<img src="resources/images/appUser.gif" border="0" onClick="showPop('specialInformationAdmin');" > 
				        <span style="position:absolute; left:100px; top:150px; width:1000px; height:400px;" id="specialInformationAdmin" class="popupWithInputText"  >
				           		<div class="text11" align="left">
				           			${activeUrlRPG_TODO}
				           			<br/><br/>
				           			<button name="specialInformationButtonClose" class="buttonGrayInsideDivPopup" type="button" onClick="hidePop('specialInformationAdmin');">Close</button> 
				           		</div>
				        </span>   		
	    				<font class="text14User" >${user.user}&nbsp;</font>${user.usrLang}</font>
	    				<font color="#FFFFFF"; style="font-weight: bold;">&nbsp;|&nbsp;&nbsp;</font>
		    			<a tabindex=-1 href="logout.do">
		    				<font class="headerMenuGreen"><img src="resources/images/home.gif" border="0">&nbsp;
		    					<font class="text14User" ><spring:message code="dashboard.menu.button"/>&nbsp;</font>
		    				</font>
		    			</a>
		    			<font color="#FFFFFF"; style="font-weight: bold;">&nbsp;&nbsp;|&nbsp;</font>
		    			<font class="text12LightGreen" style="cursor:pointer;" onClick="showPop('versionInfo');">${user.versionSpring}&nbsp;</font>
		    			<div class="text14" style="position: relative;" align="left">
							<span style="position:absolute; left:50px; top:10px; width:250px" id="versionInfo" class="popupWithInputText"  >	
			           			<b>${user.versionEspedsg}</b>
			           			<br/>
			           			&nbsp;<a href="renderLocalLog4j.do" target="_blank">log4j</a>
			           			<br/><br/>
			           			<button name="versionInformationButtonClose" class="buttonGrayInsideDivPopup" type="button" onClick="hidePop('versionInfo');">Close</button> 
				           	</span>
						</div> 
 				</div>			
			</div>

	   </div> 
   </header>
   
</div>
</html>
	
