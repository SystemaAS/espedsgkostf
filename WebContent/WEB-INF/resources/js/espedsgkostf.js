var jq = jQuery.noConflict();
var BLOCKUI_OVERLAY_MESSAGE_DEFAULT = "Vennligst vent...";

var kostaTable;
var levefTable;

var levefInitialized = false;

function initKostaSearch() {
	console.log('kostaTable', kostaTable);
	if (kostaTable != undefined) {
		console.log('initKosta already set.');
		return;
	}
	console.log('initKosta');

	let addSign = "";
	if (signatur.length > 1) { //signature is mandatory
		addSign = attkode;
	}
	//Init datatables, done once, then reload with ajax
	kostaTable = jq('#kostaTable').DataTable({
		"dom" : '<"top"f>t<"bottom"lip><"clear">',
		"ajax": {
	        "url": kostaUrl+addSign,
	        "dataSrc": ""
	    },	
		mark: true,
	    responsive: true,
		"columnDefs" : [ 
			{
				"targets" : 1,
				className: 'dt-body-center',
			    "render": function ( data, type, row, meta ) {
			    	var url= bilagUrl_read+'&kabnr='+row.kabnr; 
			    	var href = '<a href="'+url+'"' +'><img class= "img-fluid float-center" src="resources/images/update.gif" onClick="setBlockUI();"></a>';
			    	return href;
			    }			
			},
			{
				"targets" : -1,
				className: 'dt-body-center',
			    "render": function ( data, type, row, meta ) {
	           		return '<a>' +
	       			'<img class="img-fluid float-center" title="Slett post" src="resources/images/delete.gif">' +
	       			'</a>'    	
			    }
			}
			
		],		
	    "columns": [
	        { "data": "kabnr" },
	    	{
	            "orderable":      false,
	            "data":           null,
	            "defaultContent": ''
	    	},
	        { "data": "kabnr2" },
	        { "data": "kast" },
	        { "data": "kapmn" },
	        { "data": "kapår" },
	        { "data": "kafnr" },
	        { "data": "kavk" },
	        { "data": "kalnr" },
	    	{ "data": "levnavn" },	        
	        { "data": "kasg" },
	        { "data": "kabdt" },
	        { "data": "kaval" },
	        { "data": "kabl" },
	        { "data": "kamva" },
	        { "data": "kabb" },
	        { "data": "kaffdt" },
	        { "data": "katxt" },
	    	{
	        	"class":          "delete dt-body-center",
	        	"orderable":      false,
	            "data":           null,
	            "defaultContent": ''
	    	}		        
	    ],
		"lengthMenu" : [ 25, 75, 100 ],
		"language" : {
			"url" : getLanguage(lang)
		}        
	
	});

	kostaTable.on( 'click', 'td.delete img', function () {
	    let data = kostaTable.row( jq(this).parents('tr') ).data();
	    bilagUrl_delete = bilagUrl_delete + "&kabnr="+data['kabnr'];
	    
	    jq('<div></div>').dialog({
	    	title: "Slett innregnr. " + data['kabnr'] + " - bilagsnr. " + data['kabnr2'],
	    	resizable: false,
	        height: "auto",
	        width: 500,
	        modal: true,
	        buttons: {
	        	Fortsett: function() {
	            jq( this ).dialog( "close" );
	    		setBlockUI();
	    		console.log('bilagUrl_delete',bilagUrl_delete);
	            window.location = bilagUrl_delete;
	          },
	          	Avbryt: function() {
	            jq( this ).dialog( "close" );
	          }
	        },
	        open: function() {
		  		  var markup = "Er du sikker på at du vil slette denne?";
		          jq(this).html(markup);
		          jq(this).siblings('.ui-dialog-buttonpane').find('button:eq(1)').focus();
		     }            
	      });        
	
	} );	

    jq('#kostaTable').on( 'draw.dt', function () {
        unBlockUI();
    });	
	
	//init selectAttkode
	jq.ajax({
			  type: 'GET',
			  url: kodtsfUrl,
			  dataType: 'json',
			  cache: false,
			  contentType: 'application/json',
			  success: function(data) {
				jq('#selectAttkode').append('<option value="">-velg-</option>');
				jq('#selectAttkode').prop('selectedIndex', 0);
	
				_.each(data, function( d) {
					jq('#selectAttkode').append(jq('<option></option>').attr('value', d.kosfsi).text(d.kosfsi));		//d.kosfnv		
				});
				
			  }, 

			  error: function (jqXHR, exception) {
				    alert('Error loading ...look in console log.');
				    console.log(jqXHR);
			  }	
	});	
	//end init selectAttkode

	
	//init selectSuppliernr-data-ajax
	jq(".selectSuppliernr-data-ajax").select2({
			ajax: {
		    url: levefUrl,
		    dataType: 'json',
		    delay: 250,
		    data: function (params) {
		      return {
		        lnavn: params.term, // search term
		        page: params.page
		      };
		    },
		    processResults: function (data, params) {
		      params.page = params.page || 1;
		      return {
		        results: data.items,
		        pagination: {
		          more: (params.page * 30) < data.countFiltered
		        }
		      };
		    },
		    cache: true	
		  },
		  placeholder: '',
		  allowClear: true,
	  	  escapeMarkup: function (markup) { return markup; },
		  minimumInputLength: 3,
	 	  templateResult: formatData,
	  	  templateSelection: formatDataSelection
	});	
	//end selectSuppliernr-data-ajax
	
	
} //end initKostaSearch


function initLevefSearch() {
	
	console.log('initLevefSearch');
	
	console.log('levefUrl',levefUrl);
	
	
	levefTable = jq('#levefTable').DataTable({
		"dom" : '<"top">t<"bottom"flip><"clear">',
		"ajax": {
	        "url": levefUrl,
	        "dataSrc": ""
	    },	
		mark: true,			
		responsive : true,
		select : true,
		destroy : true,
		"order" : [ [ 1, "desc" ] ],
		"columns" : [ 
			{"data" : "levnr"}, 
			{"data" : "lnavn"},
			{"data" : "adr1"},
			{"data" : "adr2"},
			{"data" : "adr3"},
			{"data" : "postnr"},
			{"data" : "land"}
		 ],
		"lengthMenu" : [ 10, 25, 75],
		"language" : {
			"url" : getLanguage(lang)
		},
		
	    initComplete: function () {
	    	levefInitialized = true;
	    }

	});

	levefTable.on( 'draw.dt', function () {
	    unBlockUI();
	});		
	
}//end initLevefSearch

function loadLevef() {
	let runningUrl;
	runningUrl = getRunningLevefUrl(levefUrl);
	console.log("levef runningUrl=" + runningUrl);

	setBlockUI();
	
	levefTable.ajax.url(runningUrl);
	levefTable.ajax.reload();
//	unBlockUI(); is done in draw.dt

}

function formatData (data) {
	if (data.loading) {
		return data.text;
	}
	console.log("data",data);
	var markup = "<div>" + data.id ; 
 	markup += '<p class="text-md-left" style="font-size:75%;">' + data.text +'</p></div>';
	  
	return markup;
}

function formatDataSelection (data) {
	  return data.id || data.text;
}


function loadKosta() {
	let runningUrl;
	runningUrl = getRunningKostaUrl(kostaUrl);
	console.log("runningUrl=" + runningUrl);

	setBlockUI();
	
	kostaTable.ajax.url(runningUrl);
	kostaTable.ajax.reload();
//	unBlockUI(); is done in draw.dt

}


function loadKostb() {
	let runningUrl;
	console.log('kabnr',kabnr);
	runningUrl= getRunningKostbUrl();
	console.log("runningUrl=" + runningUrl);
	
	let kostbTable = jq('#kostbTable').DataTable({
		"dom" : '<"top">t<"bottom"flip><"clear">',
	    "ajax": {
	        "url": runningUrl,
	        "dataSrc": ""
	    },	
		responsive : true,
		"order" : [ [ 1, "desc" ] ],
		"columns" : [ 
			{"data" : "kbbnr"}, 
			{"data" : "kbavd"},
			{"data" : "kbopd"}
		],
		"lengthMenu" : [ 25, 75, 100 ],
		"language" : {
			"url" : getLanguage('NO')
		}

	});
	
} //loadKostb

function getRunningKostaUrl(kostaUrl) {
	
		var selectedBilagsnr = jq('#selectBilagsnr').val();
		var selectedInnregnr = jq('#selectInnregnr').val();
		var selectedFaktnr = jq('#selectFaktnr').val();
		var selectedSuppliernr = jq('#selectSuppliernr').val();
		var selectedAttkode = jq('#selectAttkode').val();
		var selectedKomment = jq('#selectKomment').val();
		var selectedFradato = jq('#selectFradato').val();
		var selectedFrapermnd = jq('#selectFrapermnd').val();
		var selectedFraperaar = jq('#selectFraperaar').val();
		var selectedReklamasjon = jq('#selectReklamasjon').val();	
		var selectedStatus = jq('#selectStatus').val();	
		var selectedFrisokKode = jq('#selectFrisokKode').val();			
		var selectedFrisokTxt = jq('#selectFrisokTxt').val();			
		
		
		let runningUrl = kostaUrl;
		
		if (selectedBilagsnr != "") {
			runningUrl = runningUrl + "&bilagsnr=" + selectedBilagsnr;
		} 
		if (selectedInnregnr != "") {
			runningUrl = runningUrl + "&innregnr=" + selectedInnregnr;
		} 
		if (selectedFaktnr != "") {
			runningUrl = runningUrl + "&faktnr=" + selectedFaktnr;
		} 
		if (selectedSuppliernr != "") {
			runningUrl = runningUrl + "&levnr=" + selectedSuppliernr;
		} 
		if (selectedAttkode != "") {
			runningUrl = runningUrl + "&attkode=" + selectedAttkode;
		} 
		if (selectedKomment != "") {
			runningUrl = runningUrl + "&komment=" + selectedKomment;
		} 
		if (selectedFradato != "") {
			runningUrl = runningUrl + "&fradato=" + selectedFradato;
		} 
		if (selectedFrapermnd != "") {
			runningUrl = runningUrl + "&frapermnd=" + selectedFrapermnd;
		} 
		if (selectedFraperaar != "") {
			runningUrl = runningUrl + "&fraperaar=" + selectedFraperaar;
		} 
		if (selectedReklamasjon != "") {
			runningUrl = runningUrl + "&reklamasjon=" + selectedReklamasjon;
		} 
		if (selectedStatus != "") {
			runningUrl = runningUrl + "&status=" + selectedStatus;
		} 
		if (selectedFrisokKode != "") {
			runningUrl = runningUrl + "&fskode=" + selectedFrisokKode;
		} 
		if (selectedFrisokTxt != "") {
			runningUrl = runningUrl + "&fssok=" + selectedFrisokTxt;
		} 
		
		return runningUrl;	
		
}

function getRunningKostbUrl() {
	let runningUrl = kostbUrl;
	runningUrl = runningUrl + "&kbbnr=" + kabnr;
	console.log("kostb runningUrl", runningUrl);
	
	return runningUrl;
}

function getRunningLevefUrl() {
	let runningUrl = levefUrl;

	var selectedLevnr = jq('#selectLevnr').val();
	var selectedLnavn = jq('#selectLnavn').val();

	if (selectedLevnr != "") {
		runningUrl = runningUrl + "&levnr=" + selectedLevnr;
	} 
	if (selectedLnavn != "") {
		runningUrl = runningUrl + "&lnavn=" + selectedLnavn;
	} 		
	
	console.log("levef runningUrl", runningUrl);
	
	return runningUrl;
}


jq(function() {
	jq("#selectFradato").datepicker({
		dateFormat: 'yymmdd'
	});
	jq("#selectTildato").datepicker({
		dateFormat: 'yymmdd'
	});

	jq('a#kommentar_Link').click(function() {
		jq('#kommentar_Link').attr('target','_blank');
		console.log("komm link");
		alert('TODO komm link');
//		window.open('report_dashboard_childwindow_codes.do?caller=selectKundenr_avs', "codeWin", "top=300px,left=500px,height=600px,width=800px,scrollbars=no,status=no,location=no");
	}); 

	jq('a#levnr_Link').click(function() {
		jq('#levnr_Link').attr('target','_blank');
    	window.open('childwindow_codes.do?caller=selectSuppliernr', "codeWin", "top=300px,left=500px,height=600px,width=800px,scrollbars=no,status=no,location=no");
	}); 	
	
	jq('a#gebyrkode_Link').click(function() {
		jq('#gebyrkode_Link').attr('target','_blank');
		console.log("gebyrkode link");
		alert('TODO, gebyrkode link');
//		window.open('report_dashboard_childwindow_codes.do?caller=selectKundenr_avs', "codeWin", "top=300px,left=500px,height=600px,width=800px,scrollbars=no,status=no,location=no");
	}); 	
	
	jq('a#attkode_Link').click(function() {
		jq('#attkode_Link').attr('target','_blank');
		console.log("attkode link");
		alert('TODO, attkode link');
//		window.open('report_dashboard_childwindow_codes.do?caller=selectKundenr_avs', "codeWin", "top=300px,left=500px,height=600px,width=800px,scrollbars=no,status=no,location=no");
	}); 		

	jq('a#bilagsserie_Link').click(function() {
		jq('#bilagsserie_Link').attr('target','_blank');
		console.log("bilagsserie link");
		alert('TODO, bilagsserie link');
//		window.open('report_dashboard_childwindow_codes.do?caller=selectKundenr_avs', "codeWin", "top=300px,left=500px,height=600px,width=800px,scrollbars=no,status=no,location=no");
	}); 		
	

	
});  


jq(document).keypress(function(e) {
    if(e.which == 13) {
        jq("#submitBtn").click();
    }
});

window.addEventListener('error', function(e) {
	var error = e.error;
	jq.unblockUI();
	console.log("Event e", e);

	alert('Uforutsett fel har intreffet. \n Error: '+error);

});



  