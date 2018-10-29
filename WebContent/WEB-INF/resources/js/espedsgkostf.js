var jq = jQuery.noConflict();
var BLOCKUI_OVERLAY_MESSAGE_DEFAULT = "Vennligst vent...";

function loadKosta() {
	let runningUrl;
	runningUrl= getRunningKostaUrl(kostaUrl);
	console.log("runningUrl=" + runningUrl);

	let kostaTable = jq('#kostaTable').DataTable({
			"dom" : '<"top">t<"bottom"flip><"clear">',
			responsive : true,
		select : true,
		destroy : true,
		"columnDefs" : [ 
			{
				"targets" : 0,
			    "render": function ( data, type, row, meta ) {
			    	var url= bilagUrl_read+'&kabnr='+row.kabnr; 
			    	var href = '<a href="'+url+'"' +'>'+data+'</a>';
			    	return href;
			    }
			}
		],
		"sAjaxSource" : runningUrl,
		"sAjaxDataProp" : "",
		"order" : [ [ 3, "desc" ] ],
		"aoColumns" : [ {
			"mData" : "kabnr"
		}, {
			"mData" : "kabnr2"
		}, {
			"mData" : "kafnr"
		},{
			"mData" : "kabdt"
		},{
			"mData" : "kapmn"
		},{
			"mData" : "kapår"
		},{
			"mData" : "kalnr"
		},{
			"mData" : "kasg"
		},{
			"mData" : "katxt"
		}],
		"lengthMenu" : [ 25, 75, 100 ],
		"language" : {
			"url" : getLanguage('NO')
		}

	});

	
}  //loadKosta


function loadKostb() {
	let runningUrl;
	console.log('kabnr',kabnr);
	runningUrl= getRunningKostbUrl();
	console.log("runningUrl=" + runningUrl);
	
	let kostbTable = jq('#kostbTable').DataTable({
		"dom" : '<"top">t<"bottom"flip><"clear">',
		responsive : true,
		select : true,
		destroy : true,
		"columnDefs" : [ 
			{
				"targets" : 0,
			    "render": function ( data, type, row, meta ) {
			    	var url= 'TODO';
			    	var href = '<a href="'+url+'"' +'>'+data+'</a>';
			    	return href;
			    }
			}
		],
		"sAjaxSource" : runningUrl,
		"sAjaxDataProp" : "",
		"order" : [ [ 1, "desc" ] ],
		"aoColumns" : [ {
			"mData" : "kbbnr"
		}, {
			"mData" : "kbavd"
		},{
			"mData" : "kbopd"
		}],
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
	console.log("kostbUrl",kostbUrl);
	
	let runningUrl = kostbUrl;

	runningUrl = runningUrl + "&innregnr=" + kabnr;
	
	console.log("runningUrl", runningUrl);
	
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
		console.log("levnr link");
		alert('TODO, levnr link');
//		window.open('report_dashboard_childwindow_codes.do?caller=selectKundenr_avs', "codeWin", "top=300px,left=500px,height=600px,width=800px,scrollbars=no,status=no,location=no");
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



  