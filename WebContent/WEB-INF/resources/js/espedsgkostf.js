var jq = jQuery.noConflict();
var BLOCKUI_OVERLAY_MESSAGE_DEFAULT = "Vennligst vent...";

var kostaTable;
var levefTable;
var bilagUrl_read = "kostf_bilag_edit.do?user=${user.user}&action=2";
var bilagUrl_delete = "kostf_bilag_edit.do?user=${user.user}&action=4";

//var kostaUrl2 = "/syjserviceskostf/syjsKOSTA?user=${user.user}";


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
	
} //end initKostaSearch

function getAttKode(caller){
	console.log('getAttKode, caller',caller);
	jq.ajax({
			  type: 'GET',
			  url: kodtsfUrl,
			  dataType: 'json',
			  cache: true,
			  contentType: 'application/json',
			  success: function(data) {
				jq(caller).append('<option value="">-velg-</option>');
				jq(caller).prop('selectedIndex', 0);
	
				_.each(data, function( d) {
					jq(caller).append(jq('<option></option>').attr('value', d.kosfsi).text(d.kosfsi));		//d.kosfnv		
				});
				
			  }, 
			  error: function (jqXHR, exception) {
				    alert('Error loading att.kode...look in console log.');
				    console.log("jqXHR",jqXHR);
				    console.log("exception",exception);
			  }	
	});	
}


function getBilagsSerie(caller){
	console.log('getBilagsSerie, caller',caller);
	jq.ajax({
			  type: 'GET',
			  url: kosttUrl,
			  dataType: 'json',
			  cache: true,
			  contentType: 'application/json',
			  success: function(data) {
//				jq(caller).append('<option value="">-velg-</option>');
//				jq(caller).prop('selectedIndex', 0);
	
				_.each(data, function( d) {
					jq(caller).append(jq('<option></option>').attr('value', d.kttyp).text(d.kttyp));
				});
				
			  }, 
			  error: function (jqXHR, exception) {
				    alert('Error loading bilagsserie...look in console log.');
				    console.log("jqXHR",jqXHR);
				    console.log("exception",exception);
			  }	
	});	
}

function initLevefSearch(caller) {

	levefTable = jq('#levefTable').DataTable({
		"dom" : '<"top"f>t<"bottom"lip><"clear">',
		"ajax": {
	        "url": levefUrl+"&lnavn=NONE",  //short-circuit for now...., 2018-11-03, testa denna: http://live.datatables.net/dugacuka/1/edit
	        "dataSrc": ""
	    },	
		mark: true,			
		responsive : true,
		select : true,
		destroy : true,
		"scrollY" : "300px",
		"scrollCollapse" : false,
		"order" : [ [ 3, "desc" ] ],
		"columnDefs" : [ 
			{
				"targets" : 1,
				className: 'dt-body-center',
			    "render": function ( data, type, row, meta ) {
	           		return '<a>' +
	       			'<img class="img-fluid float-center" title="Velg" src="resources/images/bebullet.gif">' +
	       			'</a>'    	
			    }
			}
		],			
		"columns" : [ 
			{"data" : "levnr"}, 
	    	{
	        	"class":          "choose dt-body-center",
	        	"orderable":      false,
	            "data":           null,
	            "defaultContent": ''
	    	},		
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

	levefTable.on( 'click', 'td.choose img', function () {	
	    let row = levefTable.row( jq(this).parents('tr') ).data();	

		opener.jq(caller).val(row.levnr);
		opener.jq(caller).change();
		opener.jq(caller).focus();
		
		window.close();
		
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
	
	setKostbViewHeader();

	let kostbTable = jq('#kostbTable').DataTable({
		"dom" : '<"top">t<"bottom"flip><"clear">',
	    "ajax": {
	        "url": runningUrl,
	        "dataSrc": ""
	    },	
	    mark: true,
		responsive : true,
		"order" : [ [ 1, "desc" ] ],
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
		"columns" : [ 
			{"data" : "kbavd"}, 
	    	{
	            "orderable":      false,
	            "data":           null,
	            "defaultContent": ''
	    	},
			{"data" : "kbopd"},
			{"data" : "ot"},
			{"data" : "fra"}, 
			{"data" : "kbnøkk"},
			{"data" : "sk"}, 
			{"data" : "kbkn"},
			{"data" : "kbvk"},
			{"data" : "val"}, 
			{"data" : "kbblhb"},
			{"data" : "kbkdm"}, 
			{"data" : "kbbilt"},
			{"data" : "kbkdmv"},
			{"data" : "vkt1"}, 
			{"data" : "vkt2"}, 
			{"data" : "ant"}, 
			{"data" : "budsjett"}, 
			{"data" : "diff"}, 
			{"data" : "gren"},
			{"data" : "kbrekl"},
			{"data" : "kbsgg"} ,
	    	{
	        	"class":          "delete dt-body-center",
	        	"orderable":      false,
	            "data":           null,
	            "defaultContent": ''
	    	}		        
			],
		"lengthMenu" : [ 25, 75, 100 ],
		"language" : {
			"url" : getLanguage('NO')
		}

	});

	kostbTable.on( 'click', 'td.delete img', function () {
	    let data = kostbTable.row( jq(this).parents('tr') ).data();
	    bilagUrl_delete = bilagUrl_delete + "&kbbnr="+data['kbbnr'];
	    
	    //TODO
	    jq('<div></div>').dialog({
	    	title: "TODO ::::Slett innregnr. " + data['kbbnr'] + " - bilagsnr. " + data['kabnr2'],
	    	resizable: false,
	        height: "auto",
	        width: 500,
	        modal: true,
	        buttons: {
	        	Fortsett: function() {
	            jq( this ).dialog( "close" );
	    		setBlockUI();
	    		console.log('bilagUrl_delete',bilagUrl_delete);
	            //window.location = bilagUrl_delete;
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
	
	
} //loadKostb


function setKostbViewHeader() {
	jq.ajax({
		  url: kostaGetUrl,
	  	  data: { innregnr : kabnr }, 
		  dataType: 'json',
		  cache: false,
		  contentType: 'application/json',
		  success: function(data) {
			jq("#kabnr").text(data.kabnr);
			jq("#kabdt").text(data.kabdt);
			jq("#kabnr2").text(data.kabnr2);			  
			jq("#kaval").text(data.kaval);	
			jq("#kalnr").text(data.kalnr);	
			jq("#levnavn").text(data.levnavn);	
			jq("#kapmn").text(data.kabmn);			  
			jq("#KAPÅR").text(data.KAPÅR);		
			jq("#tilfordel").text(data.kabl);	
			jq("#fordelt").text(data.fordelt);	
		  
		  }, 
		  error: function (jqXHR, exception) {
		  	console.log("kabnr dont exist", kabnr);
		    console.log("jqXHR",jqXHR);
		    console.log("exception",exception);
		  }	
	});	
	
}

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

	jq("#kabdt").datepicker({  //Bilagsdato
		dateFormat: 'yymmdd'
	});	

	jq("#kaffdt").datepicker({ //Forfallsdato
		dateFormat: 'yymmdd'
	});		
	
	jq("#kalnr").blur(function() { 
		console.log('kalnr', jq("#kalnr").val());
		let kalnr = jq("#kalnr").val();  //Lev.nr
		let kabdt =  jq("#kabdt").val(); //Bilagsdato
		let kabb =  jq("#kabb").val(); //Bet.bet
		console.log('kalnr',kalnr);
		if (kalnr != undefined && kalnr.length > 0 ) {
			jq.ajax({
				  url: levefUrlGet,
			  	  data: { levnr : jq("#kalnr").val() }, 
				  dataType: 'json',
				  cache: false,
				  contentType: 'application/json',
				  success: function(data) {
					  console.log('data',data);
					  if (data != null) {
						jq("#levnavn").val(data.lnavn);
						jq("#kabb").val(data.betbet);
						jq("#kaval").val(data.valkod);	
						if (kabdt != undefined && kabdt.length > 0) {
							let kabdtParsed = parseSyspedDato(kabdt);
							let result = new Date(kabdtParsed);
							result.setDate(result.getDate() + kabb);
							let kaffdt = formatSyspedDato(result);
	
							jq("#kaffdt").val(kaffdt);	

						}
					  }
				  }, 
				  error: function (jqXHR, exception) {
					  	console.log("Kalnr dont exist", kalnr);
					    console.log("jqXHR",jqXHR);
					    console.log("exception",exception);
				  }	
			});	
		}
	
	});	
	
	jq("#kabdt").blur(function() { 
		let kabdt =  jq("#kabdt").val(); //Bilagsdato
		
		if (kabdt != undefined && kabdt.length > 0) {
			let year = kabdt.substring(2,4);
			let month = kabdt.substring(4,6);
			
			jq("#kapmn").val(month);	
			jq("#KAPÅR").val(year);	

		}		
		
		
	});	
	
	jq('a#kommentar_Link').click(function() {
		jq('#kommentar_Link').attr('target','_blank');
		console.log("komm link");
		alert('TODO komm link');
//		window.open('report_dashboard_childwindow_codes.do?caller=selectKundenr_avs', "codeWin", "top=300px,left=500px,height=600px,width=800px,scrollbars=no,status=no,location=no");
	}); 

	//search
	jq('a#levnr_Link').click(function() {
		jq('#levnr_Link').attr('target','_blank');
    	window.open('childwindow_codes.do?caller=selectSuppliernr', "codeWin", "top=300px,left=500px,height=600px,width=800px,scrollbars=no,status=no,location=no");
	}); 	
	//edit
	jq('a#levnr_Link2').click(function() {
		jq('#levnr_Link2').attr('target','_blank');
    	window.open('childwindow_codes.do?caller=kalnr', "codeWin", "top=300px,left=500px,height=600px,width=800px,scrollbars=no,status=no,location=no");
	}); 
	
	jq('a#gebyrkode_Link').click(function() {
		jq('#gebyrkode_Link').attr('target','_blank');
		console.log("gebyrkode link");
		alert('TODO, gebyrkode link');
//		window.open('report_dashboard_childwindow_codes.do?caller=selectKundenr_avs', "codeWin", "top=300px,left=500px,height=600px,width=800px,scrollbars=no,status=no,location=no");
	}); 	

	jq('a#valutakode_Link').click(function() {
		jq('#valutakode_Link').attr('target','_blank');
		console.log("valutakode link");
		alert('TODO, valutakode link');
//		window.open('report_dashboard_childwindow_codes.do?caller=selectKundenr_avs', "codeWin", "top=300px,left=500px,height=600px,width=800px,scrollbars=no,status=no,location=no");
	}); 	
	
	
	jq('a#bilagsserie_Link').click(function() {
		jq('#bilagsserie_Link').attr('target','_blank');
		console.log("bilagsserie link");
		alert('TODO, bilagsserie link');
//		window.open('report_dashboard_childwindow_codes.do?caller=selectKundenr_avs', "codeWin", "top=300px,left=500px,height=600px,width=800px,scrollbars=no,status=no,location=no");
	}); 		
	
	/*the asterix*/
	jq("input[required]").parent("label").addClass("required");
	
});  


function formatSyspedDato(dato) {
	return jq.datepicker.formatDate('yymmdd', dato);	
}

function parseSyspedDato(dato) {
	return jq.datepicker.parseDate('yymmdd', dato);
}

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