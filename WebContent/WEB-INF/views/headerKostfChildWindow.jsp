<!DOCTYPE html>
<%@page pageEncoding="UTF-8" contentType="text/html; charset=UTF-8"%>
<%@ include file="/WEB-INF/views/include.jsp" %>

<html>
	<head>
		<meta charset="utf-8">
	    <meta name="viewport" content="width=device-width, initial-scale=1, shrink-to-fit=no">
		
		<title>eSpedsg - <spring:message code="search.label"/></title>

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
		</script>


	</head>
	
</html>
	
