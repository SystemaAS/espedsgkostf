var jq = jQuery.noConflict();
var BLOCKUI_OVERLAY_MESSAGE_DEFAULT = "Vennligst vent...";

function getRunningUrl(baseUrl) {
		
		var selectedBilagsnr = jq('#selectBilagsnr').val();
		var selectedInnregnr = jq('#selectInnregnr').val();
		var selectedFaktnr = jq('#selectFaktnr').val();
		var selectedSuppliernr = jq('#selectSuppliernr').val();
		var selectedAttkode = jq('#selectAttkode').val();
		
		let runningUrl = baseUrl;
		
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
		
	
			
		
		return runningUrl;	
		
}

jq(function() {
	jq("#selectFradato").datepicker({
		dateFormat : 'yy-mm-dd'
	});
	jq("#selectTildato").datepicker({
		dateFormat : 'yy-mm-dd'
	});
});  
  