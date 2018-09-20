  //this variable is a global jQuery var instead of using "$" all the time. Very handy
  var jq = jQuery.noConflict();
  var counterIndex = 0;
  var BLOCKUI_OVERLAY_MESSAGE_DEFAULT = "Please wait...";

//BlockUI behaviour
  function setBlockUI(element){
	  setBlockUI();
  }
  jq(function() {
	  jq('#alinkOrderListId').click(function() { 
		  setBlockUI();
	  }); 
	  jq('#alinkTripListId').click(function() { 
		  //not working ... setBlockUI();
		  jq.blockUI({ css: { fontSize: '22px' }, message: BLOCKUI_OVERLAY_MESSAGE_DEFAULT});
	  }); 
  });
  //End BlockUI
  
  //Global functions
  function g_getCurrentYearStr(){
	  return new Date().getFullYear().toString();
  }
  function g_getCurrentMonthStr(){
	  var currentMonth = new Date().getMonth() + 1;
	  var currentMonthStr = currentMonth.toString();
	  if (currentMonth < 10) { currentMonthStr = '0' + currentMonth; }
	  return currentMonthStr;
  }
  
  //---------------------------------
  //START - Drag from Orders to Trip 
  //---------------------------------
  	//this drag function is used when the order is the SOURCE of a drag and not the target
	function drag(ev) {
	    ev.dataTransfer.setData("text", ev.target.id);
	}
	//END Drag
	
	//---------------------------------
	//START - Drop from Trips to Order
	//---------------------------------
	//this drag function is used when the order is the TARGET of a drag and not the source
	function highlightDropArea(ev) {
  		var data = ev.dataTransfer.getData("text");
  		jq("#"+ev.target.id).addClass('isa_blue');
	}
	//this drag function is used when the order is the TARGET of a drag and not the source
    function noHighlightDropArea(ev) {
    	//jq("#"+ev.target.id).css("color", "red");
    	jq("#"+ev.target.id).removeClass('isa_blue');
	}
    //this drag function is used when the order is the TARGET of a drag and not the source
    function allowDrop(ev) {
    	ev.preventDefault();
	}
    
    //this drag function is used when the order is the TARGET of a drag and not the source
	function drop(ev) {
	    ev.preventDefault();
	    jq("#"+ev.target.id).removeClass('isa_blue');
	    
	    var data = ev.dataTransfer.getData("text");
	    //DEBUG alert(data);
	    var record = data.split("@");
	    var trip = record[1].replace("tripnr_","");
	    //DEBUG alert(event.target.id);
	    if(trip.indexOf("_") == -1){ //meaning the trip is valid
		    //get target ids
		    var recordTarget = event.target.id.split("_");
		    var avd = recordTarget[0].replace("davd","");
		    var opd = recordTarget[1].replace("dopd","");
		    //DEBUG alert(trip + "XX" + avd + "XX" + opd);
		    if(trip!='' && avd!='' && opd!=''){
		    	setTripOnOrder(trip, avd, opd);
		    }else{
		    	alert("Ordre/tur/avd mangler?")
		    }
	    }
	    //N/A
	    //ev.target.appendChild(document.getElementById(data));
	}
	//Connect trip with order
  	//if = OK then go to order (GUI)
  	function setTripOnOrder(trip, avd, opd){
  		var requestString = "&wmode=A&wstur=" + trip + "&wsavd=" + avd + "&wsopd=" + opd;
  		jq.ajax({
		  	  type: 'GET',
		  	  url: 'addTripToOrder_TransportDisp.do',
		  	  data: { applicationUser : jq('#applicationUser').val(),
  					  requestString : requestString },
		  	  dataType: 'json',
		  	  cache: false,
		  	  contentType: 'application/json',
		  	  success: function(data) {
		  		var len = data.length;
		  		if(len==1){
			  		//update = OK
		  			reloadParentOrder(trip,avd,opd);
		  		}else{
		  			//update != OK
		  			alert("Error on order update [addTripToOrder_TransportDisp.do]...?");
		  		}
		  	  },
		  	  error: function() {
		  		  alert('Error loading ...');
			  }
  		});
  	}
  	
  	//this drag function is used when the list of current order LIST on allocated TRIP is the TARGET of a drag and not the source
    function dropX(ev) {
    	ev.preventDefault();
    	
    	jq("#"+ev.target.id).removeClass('isa_blue');
	    
	    var data = ev.dataTransfer.getData("text");
	    //alert(data);
	    var record = data.split("@");
	    var opd = record[1].replace("opd_","");
	    var existentTripNr = record[2].replace("tripnr_","");
	    
	    //meaning the trip is valid (valid opd and no trip previously attached)
	    if(opd.indexOf("_") == -1 && existentTripNr == ""){ 
		    //DEBUG alert(event.target.id);
		    //get target ids
		    var recordTarget;var avd; var trip;
		    if(event.target.id.indexOf("oncontainer") > -1){ 
		    	//alert("A");
		    	recordTarget = event.target.id.split("_");
		    	avd = recordTarget[0].replace("dtuavd","");
		    	trip = recordTarget[1].replace("dtupro","");
		    }else{ //dropping in the form area
		    	//alert("B");
		    	avd = jq("#tuavd").val();
		    	trip = jq("#tupro").val();
		    }
		    //DEBUG alert(trip + "XX" + avd + "XX" + opd);
		    
		    if(trip!='' && avd!='' && opd!=''){
		    	setOrderOnTrip(trip, avd, opd);
		    }else{
		    	alert("Ordre/tur/avd mangler?");
		    }
	    }else{
	    	alert("Ordre har tur:" + existentTripNr + " allerede");
	    }
	    //N/A
	    //ev.target.appendChild(document.getElementById(data));
	    
	}
    //Connect order with trip
  	//if = OK then go to trip list (GUI)
  	function setOrderOnTrip(trip, avd, opd){
  		var requestString = "&wmode=A&wstur=" + trip + "&wsavd=" + avd + "&wsopd=" + opd;
  		jq.ajax({
		  	  type: 'GET',
		  	  url: 'addTripToOrder_TransportDisp.do',
		  	  data: { applicationUser : jq('#applicationUser').val(),
  					  requestString : requestString },
		  	  dataType: 'json',
		  	  cache: false,
		  	  contentType: 'application/json',
		  	  success: function(data) {
		  		var len = data.length;
		  		if(len==1){
			  		//update = OK
		  			reloadParentTrip(trip,avd,opd);
		  			
		  		}else{
		  			//update != OK
		  			alert("Error on order update [addTripToOrder_TransportDisp.do]...?");
		  		}
		  	  },
		  	  error: function() {
		  		  alert('Error loading ...');
			  }
  		});
  	}
  //------------------------------------------
  //END - Drag and drop from Trips to Order
  //------------------------------------------
  	
    //Reload the order after being coupled with the trip 
    //NOTE: this function is call from: 
    //(1) from this same file in the above ajax: setTripOnOrder(trip,avd,opd)
    function reloadParentOrder(trip, avd, opd) {
    	window.location = "transportdisp_mainorder.do?hepro=" + trip + "&heavd=" + avd + "&heopd=" + opd;
    	
    	//in case we want to refresh the order list (unlikely)
    	//window.location = "transportdisp_mainorderlist.do?action=doFind&avd=" + avd;
    	
    }
    
    //Reload the order after being coupled with the trip 
    //NOTE: this function is call from: 
    //(1) from this same file in the above ajax: setTripOnOrder(trip,avd,opd)
    function reloadParentTrip(trip, avd, opd) {
    	window.location = "transportdisp_mainorderlist.do?action=doFind&wssavd=" + avd + "&wstur=" + trip;
    	
    	//in case we want to refresh the order list (unlikely)
    	//window.location = "transportdisp_mainorder.do?hepro=" + trip + "&heavd=" + avd + "&heopd=" + opd;
    	
    }
	
 
  //Stretch workplace
  jq(function() {
	  jq("#checkBoxVisibility").click(function() {
		  if (jq(this).is(":checked")) {
			  jq('#tdsBanner').hide();
		  }else{
			  jq('#tdsBanner').show();
		  }
	  });
	  
	  jq("#fromDateF").datepicker({ 
		  onSelect: function(date) {
		  	jq("#fromDateT").focus();
	      },
		  dateFormat: 'yymmdd',
		  firstDay: 1 //monday
	  });
	  jq("#fromDateT").datepicker({ 
		  onSelect: function(date) {
		  	jq("#to").focus();
	      },
		  dateFormat: 'yymmdd',
		  firstDay: 1 //monday
	  });
	  jq("#toDateF").datepicker({ 
		  onSelect: function(date) {
		  	jq("#toDateT").focus();
	      },
		  dateFormat: 'yymmdd',
		  firstDay: 1 //monday
	  });
	  jq("#toDateT").datepicker({ 
		  onSelect: function(date) {
		  	jq("#submit").focus();
	      },
		  dateFormat: 'yymmdd',
		  firstDay: 1 //monday
	  });

	  jq("#fromDateF").blur(function(){
		  //now check the user input alternatives
		  var str = jq("#fromDateF").val();
		  if(str!=''){
			  var length = str.length;
			  if(length==2){
				  jq("#fromDateF").val(g_getCurrentYearStr() + g_getCurrentMonthStr() + str);  
			  }else if (length==4){
				  var userDay = str.substring(0,2);
				  var userMonth = str.substring(2,4);
				  jq("#fromDateF").val(g_getCurrentYearStr() + userMonth + userDay);
			  }
		  }
	  });
	  jq("#fromDateT").blur(function(){
		  //now check the user input alternatives
		  var str = jq("#fromDateT").val();
		  if(str!=''){
			  var length = str.length;
			  if(length==2){
				  jq("#fromDateT").val(g_getCurrentYearStr() + g_getCurrentMonthStr() + str);  
			  }else if (length==4){
				  var userDay = str.substring(0,2);
				  var userMonth = str.substring(2,4);
				  jq("#fromDateT").val(g_getCurrentYearStr() + userMonth + userDay);
			  }
		  }
	  });
	  jq("#toDateF").blur(function(){
		  //now check the user input alternatives
		  var str = jq("#toDateF").val();
		  if(str!=''){
			  var length = str.length;
			  if(length==2){
				  jq("#toDateF").val(g_getCurrentYearStr() + g_getCurrentMonthStr() + str);  
			  }else if (length==4){
				  var userDay = str.substring(0,2);
				  var userMonth = str.substring(2,4);
				  jq("#toDateF").val(g_getCurrentYearStr() + userMonth + userDay);
			  }
		  }
	  });
	  jq("#toDateT").blur(function(){
		  //now check the user input alternatives
		  var str = jq("#toDateT").val();
		  if(str!=''){
			  var length = str.length;
			  if(length==2){
				  jq("#toDateT").val(g_getCurrentYearStr() + g_getCurrentMonthStr() + str);  
			  }else if (length==4){
				  var userDay = str.substring(0,2);
				  var userMonth = str.substring(2,4);
				  jq("#toDateT").val(g_getCurrentYearStr() + userMonth + userDay);
			  }
		  }
	  });
	  
  });	
  
  jq(function() {
	  
	  jq("#cnButton").click(function() {
		  setBlockUI();
		  if(jq('#avd').val()!='' && jq('#tur').val()!=''){
			  window.location = "transportdisp_mainorder.do?heavd=" + jq('#avd').val() + "&hepro=" + jq('#tur').val();
		  }else{
			  window.location = "transportdisp_mainorder.do?heavd=" + jq('#userAvd').val();
		  }
	  });
	  
	  jq('#objAvdGroupsList').click(function() {
		  if(jq('#divAvdGroupsList').css('display') == 'none'){
			  jq('#divAvdGroupsList').css('display','block');
		  }else{
			  jq('#divAvdGroupsList').css('display','none');
		  }
	  });
	  /* in case of drop down
	  jq('#avdGroupsList').change(function() {
		  jq('#divAvdGroupsList').css('display','none');
		  var value = this.value;
		  jq('#avd').val(value);
		  
	  });*/
	  
  });
  
  function doPickAvdGroup(element){
	  jq('#divAvdGroupsList').css('display','none');
	  var rawId = element.id;
	  var id = rawId.replace("id_","");
	  jq('#avd').val(id);
  }

  //---------------------------------------
  //DELETE Order
  //This is done in order to present a jquery
  //Alert modal pop-up
  //----------------------------------------
  function doPermanentlyDeleteOrder(element){
	  //start
	  var record = element.id.split('@');
	  var avd = record[0];
	  var opd = record[1];
	  avd= avd.replace("avd_","");
	  opd= opd.replace("opd_","");
	  	//Start dialog
	  	jq('<div></div>').dialog({
	        modal: true,
	        title: "Dialog - Slett Oppdrag " + opd,
	        buttons: {
		        Fortsett: function() {
	        		jq( this ).dialog( "close" );
		            //do delete
		            jq.blockUI({ message: BLOCKUI_OVERLAY_MESSAGE_DEFAULT});
		            window.location = "transportdisp_mainorderlist_permanently_delete_order.do?action=doDelete" + "&avd=" + avd + "&opd=" + opd;
		        },
		        Avbryt: function() {
		            jq( this ).dialog( "close" );
		        }
	        },
	        open: function() {
		  		  var markup = "Er du sikker på at du vil slette denne?";
		          jq(this).html(markup);
		          //make Cancel the default button
		          jq(this).siblings('.ui-dialog-buttonpane').find('button:eq(1)').focus();
		     }
		});  //end dialog
  }	  
  //-----------------------------------------------------------
  //Go to the specific order through AJAX
  //Reason: we must validate first if the order can be updated
  //The user will be promted with a reasonable pop-up...
  //-----------------------------------------------------------
  function goToSpecificOrder(element){
	  //start
	  var record = element.id.split('@');
	  var hepro = record[0];
	  var heavd = record[1];
	  var heopd = record[2];
	  hepro = hepro.replace("hepro_",""); 
	  heavd = heavd.replace("heavd_",""); 
	  heopd = heopd.replace("heopd_","");
	  //request till Ajax
	  var requestString = "&heavd="+ heavd + "&heopd=" + heopd;
	  //DEBUG --> 
	  //alert(requestString);
	  jq.ajax({
		  type: 'GET',
	  	  url: 'validateSpecificOpenOrder_TransportDisp.do',
	  	  data: { applicationUser : jq('#applicationUser').val(), 
	  		  	  requestString : requestString }, 
	  	  dataType: 'json',
	  	  cache: false,
	  	  contentType: 'application/json',
	  	  success: function(data) {
	  		var len = data.length;
	  		//alert(len);
	  		for ( var i = 0; i < len; i++) {
	  			if(data[i].errMsg!=''){
	  					//alert(data[i].errMsg);
	  					jq('<div></div>').dialog({
		  			        modal: true,
		  			        title: "Dialog",
		  			        open: function() {
		  			          var markup = data[i].errMsg;
		  			          jq(this).html(markup);
		  			        },
		  			        buttons: {
		  			          Ok: function() {
		  			            jq( this ).dialog( "close" );
		  			            //get back to the starting point
		  			            //TODO maybe to refresh. N/A at the moment...-->jq.blockUI({ message: BLOCKUI_OVERLAY_MESSAGE_DEFAULT});
		  			            //TODO maybe to refresh. N/A at the moment...-->window.location = "transportdisp_mainorderlist.do?action=doFind";
		  			          }
		  			        }
	  					});  //end confirm dialog
	  				
	  			}else{
	  				//proceed to the redirect for validate=OK
	  				jq.blockUI({ css: { fontSize: '22px' }, message: BLOCKUI_OVERLAY_MESSAGE_DEFAULT});
	  				window.location = "transportdisp_mainorder.do?user=" + jq('#applicationUser').val() + "&hepro=" + hepro + "&heavd=" + heavd + "&heopd=" + heopd;
	  			}
	  		}
	  	  },
	  	  error: function() {
		  	    alert('Error loading ...');
	  	  }
		  
	  });
  }
  
  
  
  //-------------------
  //Datatables jquery
  //-------------------
  //private function
  function filtersInit () {
    jq('#currentOrders').DataTable().search(
    		jq('#currentOrders_filter').val()
    ).draw();
    jq('#openOrders').DataTable().search(
    		jq('#openOrders_filter').val()
    ).draw();
    
  }

  jq(document).ready(function() {
    //init table (no ajax, no columns since the payload is already there by means of HTML produced on the back-end)
	jq('#currentOrders').dataTable( {
	  //"autoWidth":true,	
	  "jQueryUI": false,
	  "dom": '<"transpDispMainOrderListFilter"f>t<"bottom"lirp><"clear">',
	  "scrollY": "350px",
	  "scrollX":true,
	  "scrollCollapse": false,
	  //"autoWidth": false, //for optimization purposes when initializing the table
	  "lengthMenu": [ 50, 75, 100],
	  "fnDrawCallback": function( oSettings ) {
		  jq('.dataTables_filter input').addClass("inputText12LightYellow");
      }
	} );
	//css styling
    jq('.dataTables_filter input').addClass("inputText12LightYellow");
    
    //event on input field for search
    jq('input.currentOrders_filter').on( 'keyup click', function () {
    		filtersInit();
    } );
    
    //init table (no ajax, no columns since the payload is already there by means of HTML produced on the back-end)
	jq('#openOrders').dataTable( {
	  "jQueryUI": false,
	  "dom": '<"transpDispMainOrderListFilter"f>t<"bottom"lirp><"clear">',
	  "scrollY": "700px",
	  "scrollCollapse": false,
	  //"autoWidth": false, //for optimization purposes when initializing the table
	  "lengthMenu": [ 50, 75, 100],
	  "fnDrawCallback": function( oSettings ) {
		  jq('.dataTables_filter input').addClass("inputText12LightYellow");
      }
	} );
	//css styling
    jq('.dataTables_filter input').addClass("inputText12LightYellow");
	
    //event on input field for search
    jq('input.openOrders_filter').on( 'keyup click', function () {
    		filtersInit();
    });
    
    //init economy-matrix draggable poput 
    showDialogMatrixDraggable();
    
  });
  //draggable window
  function showDialogMatrixDraggable(){
	  //jq( "#dialogDraggableMatrix" ).removeClass("popup");
	  jq( "#dialogDraggableMatrix" ).dialog({
		  minHeight: 300,
		  minWidth:450,
		  position: { my: "right top", at: "right bottom", of: window }
	  }); 
	  jq( "#dialogDraggableMatrix" ).focus();
  }
  
  
  //----------------------------------------
  //Iterate through check-boxes to update
  //----------------------------------------
  function getValidCheckis(record) {
	  var FIELD_SEPARATOR = "@";
	  var requestString = "";
	  
	  //Check current orders
	  jq( ".clazz_checkis_currentorders" ).each(function( i ) {
		  var id = this.id;
		  if (jq(this).is(":checked")) {
			  //DEBUG alert("checked:" + id);
			  var rawString = id.split(FIELD_SEPARATOR);
			  if(requestString==""){ requestString = rawString[1]; }
			  else{ requestString += FIELD_SEPARATOR + rawString[1]; }
		  }
	  });
	  //Check open orders
	  if(requestString==""){
		  jq( ".clazz_checkis_openorders" ).each(function( i ) {
			  var id = this.id;
			  if (jq(this).is(":checked")) {
				  //DEBUG alert("checked:" + id);
				  var rawString = id.split(FIELD_SEPARATOR);
				  if(requestString==""){ requestString = rawString[1]; }
				  else{ requestString += FIELD_SEPARATOR + rawString[1]; }
			  }
		  });
	  }
	  //DEBUG alert(requestString);
	  //Now update all trips with checked check boxes if any
	  if(requestString!="" && requestString!=null){
		  jq.ajax({
		  	  type: 'GET',
		  	  url: 'updateMainOrdersLists_TransportDisp.do',
		  	  data: { applicationUser : jq('#applicationUser').val(), 
		  		  	  requestString : requestString }, 
		  	  dataType: 'json',
		  	  cache: false,
		  	  contentType: 'application/json',
		  	  async: false, //only way to make synchronous calls. Otherwise will all ajax dependent functions will execute asynchronously
		  	  success: function(data) {
		  		var len = data.length;
		  		for ( var i = 0; i < len; i++) {
		  			var redirectParams = "&wssavd=" + data[i].tuavd + "&wstur=" + data[i].tupro;
		  			if(data[i].errMsg != null){
		  				redirectParams = redirectParams + "&err=" + data[i].errMsg;
		  			}
		  			//we send the redirect after all updates in order to refresh...
		  			window.location = "transportdisp_mainorderlist.do?action=doFind" + redirectParams;
		  			
		  		}
		  	  },
		  	  error: function() {
			  	    alert('Error loading ...');
		  	  }
		  });
	  }
  }
  
  
//----------------------------------------
  //Iterate through check-boxes to update
  //----------------------------------------
  function getValidPositions(record) {
	  var FIELD_SEPARATOR = "@";
	  var WSPOS_SUFFIX = "&wspos=";
	  var tripNr = jq('#tripNr').val();
	  //alert(tripNr);
	  var requestString = "";
	  
	  //Check current orders
	  jq( ".clazz_position_currentorders" ).each(function( i ) {
		  
		  var counter = i + 1;
		  var wsposValue = jq('#wspos'+counter).val();
		  var id = jq('#wspos'+counter).attr('title');
		  var rawString = id.split(FIELD_SEPARATOR);
		  //alert(id);
		  //alert(wsposValue);
		  
		  if(requestString==""){ 
			  requestString = rawString[1]; 
			  if(wsposValue!=""){
				  requestString += WSPOS_SUFFIX + wsposValue;
			  }
		  }else{ 
			  requestString += FIELD_SEPARATOR + rawString[1];
			  if(wsposValue!=""){
				  requestString += WSPOS_SUFFIX + wsposValue;
			  }
		  }
	  });
	  //alert(requestString);
	  //Now update all trips position values
	  
	  jq.ajax({
	  	  type: 'GET',
	  	  url: 'updatePositionsMainOrdersLists_TransportDisp.do',
	  	  data: { applicationUser : jq('#applicationUser').val(), 
	  		  	  requestString : requestString }, 
	  	  dataType: 'json',
	  	  cache: false,
	  	  contentType: 'application/json',
	  	  success: function(data) {
	  		var len = data.length;
	  		for ( var i = 0; i < len; i++) {
	  			//we send the redirect after all updates in order to refresh...
	  			window.location = "transportdisp_mainorderlist.do?action=doFind&wssavd=" + data[i].tuavd + "&wstur=" + tripNr;
	  		}
	  	  },
	  	  error: function() {
		  	    alert('Error loading ...');
	  	  }
	  });
	  
	 
  }
  
  
  
  //-----------------------------------
  //START Model dialog Copy Order
  //-----------------------------------
  //Initialize <div> here
  jq(function() { 
	  jq( ".clazz_dialog" ).each(function(){
		jq(this).dialog({
			autoOpen: false,
			modal: true
		});
	  });
  });
  //Present dialog box onClick (href in parent JSP)
  jq(function() {
	  jq(".copyLink").click(function() {
		  var id = this.id;
		  counterIndex = id.replace("copyLink","");
		  //setters (add more if needed)
		  jq('#dialog'+counterIndex).dialog( "option", "title", "Kopi Oppdrag " + jq('#originalOpd'+counterIndex).val() );
		  
		  //deal with buttons for this modal window
		  jq('#dialog'+counterIndex).dialog({
			 buttons: [ 
	            {
				 id: "dialogSave"+counterIndex,	
				 text: "Fortsett",
				 click: function(){
					 		jq('#copyForm'+counterIndex).submit();
				 		}
			 	 },
	 	 		{
			 	 id: "dialogCancel"+counterIndex,
			 	 text: "Avbryt", 
				 click: function(){
					 		//back to initial state of form elements on modal dialog
					 		jq("#dialogSave"+counterIndex).button("option", "disabled", true);
					 		jq( this ).dialog( "close" ); 
					 		  
				 		} 
	 	 		 } ] 
			  
		  });
		  //init values
		  //jq("#dialogSave"+counterIndex).button("option", "disabled", true);
		  
		  //open now
		  jq('#dialog'+counterIndex).dialog('open');
		 
	  });
  });
  
  //Events for the html elements (some kind of "implicit validation")
  jq(function() {
	  jq(".newAvd").blur(function() {
		  if(jq("#dialog"+counterIndex).find('.newAvd').val()!=''){
			  jq("#dialogSave"+counterIndex).button("option", "disabled", false);
			  
		  }else{
			  jq("#dialogSave"+counterIndex).button("option", "disabled", true);
		  }
	  });
	  /*
	  jq(".newSign").change(function() {
		  if(jq("#dialog"+counterIndex).find('.newAvd').val()!='' && jq("#dialog"+counterIndex).find('.newSign').val()!=''){
			  jq("#dialogSave"+counterIndex).button("option", "disabled", false);
			  
		  }else{
			  jq("#dialogSave"+counterIndex).button("option", "disabled", true);
		  }
	  });
	  */
	  
  });
  //---------------------------------
  //END Model dialog Copy Order
  //---------------------------------

//-----------------------------------
  //START Model dialog Move Order
  //-----------------------------------
//Initialize <div> here
  jq(function() { 
	  jq( ".clazz_dialogMove" ).each(function(){
		jq(this).dialog({
			autoOpen: false,
			modal: true
		});
	  });
  });
  //Present dialog box onClick (href in parent JSP)
  jq(function() {
	  jq(".moveLink").click(function() {
		  var id = this.id;
		  counterIndex = id.replace("moveLink","");
		  //setters (add more if needed)
		  jq('#dialogMove'+counterIndex).dialog( "option", "title", "Flytte Oppdrag " + jq('#originalOpd'+counterIndex).val() );
		  
		  //deal with buttons for this modal window
		  jq('#dialogMove'+counterIndex).dialog({
			 buttons: [ 
	            {
				 id: "dialogSaveMove"+counterIndex,	
				 text: "Fortsett",
				 click: function(){
					 		jq('#moveForm'+counterIndex).submit();
				 		}
			 	 },
	 	 		{
			 	 id: "dialogCancelMove"+counterIndex,
			 	 text: "Avbryt", 
				 click: function(){
					 		//back to initial state of form elements on modal dialog
					 		jq("#dialogSaveMove"+counterIndex).button("option", "disabled", true);
					 		jq( this ).dialog( "close" ); 
					 		  
				 		} 
	 	 		 } ] 
			  
		  });
		  //init values
		  //jq("#dialogSaveMove"+counterIndex).button("option", "disabled", true);
		  
		  //open now
		  jq('#dialogMove'+counterIndex).dialog('open');
		 
	  });
  });
  
  //Events for the drop downs (some kind of "implicit validation" since all drop downs are mandatory)
  jq(function() {
	  jq(".newAvdMove").blur(function() {
		  if(jq("#dialogMove"+counterIndex).find('.newAvdMove').val()!=''){
			  jq("#dialogSaveMove"+counterIndex).button("option", "disabled", false);
			  
		  }else{
			  jq("#dialogSaveMove"+counterIndex).button("option", "disabled", true);
		  }
	  });
	  /*
	  jq(".newSign").change(function() {
		  if(jq("#dialog"+counterIndex).find('.newAvd').val()!='' && jq("#dialog"+counterIndex).find('.newSign').val()!=''){
			  jq("#dialogSave"+counterIndex).button("option", "disabled", false);
			  
		  }else{
			  jq("#dialogSave"+counterIndex).button("option", "disabled", true);
		  }
	  });
	  */
	  
  });
  //---------------------------------
  //END Model dialog Copy Order
  //---------------------------------

  
  //-----------------------------
  //START Model dialog: "SMS"
  //---------------------------
  //Initialize <div> here
  jq(function() { 
	  jq("#dialogSMS").dialog({
		  autoOpen: false,
		  maxWidth:400,
          maxHeight: 400,
          width: 360,
          height: 300,
		  modal: true,
		  dialogClass: 'main-dialog-class'
	  });
  });

  jq(function() {
	  jq("#smsButton").click(function() {
		  presentSmsDialog();
	  });
  });
  
  /*
  ---------------------
  /PRESENT SMS DIALOG
  ---------------------
   */
  function presentSmsDialog(){
	//setters (add more if needed)
	  jq('#dialogSMS').dialog( "option", "title", "Send SMS" );
	  //deal with buttons for this modal window
	  jq('#dialogSMS').dialog({
		 buttons: [ 
            {
			 id: "dialogSaveTU",	
			 text: "Send",
			 click: function(){
				 		if(jq("#smsnr").val() != ''){
				 			sendSMS();
				 		}
		 			}
		 	 },
  			{
		 	 id: "dialogCancelTU",
		 	 text: "Lukk", 
			 click: function(){
				 		//back to initial state of form elements on modal dialog
				 		//jq("#dialogSaveTU").button("option", "disabled", true);
				 		jq("#smsnr").val("");
				 		jq("#smsStatus").text("");
				 		jq("#smsStatus").removeClass( "isa_error" );
				 		jq("#smsStatus").removeClass( "isa_success" );
		  				jq( this ).dialog( "close" ); 
			 		} 
 	 		 } ] 
	  });
	  //init values
	  //jq("#dialogSaveTU").button("option", "disabled", true);
	  //open now
	  jq('#dialogSMS').dialog('open');
  }
  
  //new line
  function sendSMS() {
	  
	  jq.ajax({
	  	  type: 'GET',
	  	  url: 'sendSMSFromTur_TransportDisp.do',
	  	  data: { applicationUser : jq('#applicationUser').val(),
	  		  	  tur : jq("#tripNr").val(),
	  		  	  smsnr : jq("#smsnr").val(),
	  		  	  smslang : jq("#smslang").val() },
	  	  dataType: 'json',
	  	  cache: false,
	  	  contentType: 'application/json',
	  	  success: function(data) {
	  		var len = data.length;
	  		
	  		for ( var i = 0; i < len; i++) {
	  			if(data[i].errMsg != ''){
	  				jq("#smsStatus").removeClass( "isa_success" );
	  				jq("#smsStatus").addClass( "isa_error" );
	  				jq("#smsStatus").text("SMS error: " + data[i].smsnr + " " + data[i].errMsg);
	  			}else{
	  				jq("#smsStatus").removeClass( "isa_error" );
	  				jq("#smsStatus").addClass( "isa_success" );
	  				jq("#smsStatus").text("SMS er sendt ti" + data[i].smsnr + " (loggført i Hendelsesloggen)");
	  			}
	  		}
	  	  },
	  	  error: function() {
	  	    alert('Error loading on Ajax callback (?) sendSMSFromTur...check js');
	  	  }
	  });
  }	

  

  
  