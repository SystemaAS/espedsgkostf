var jq = jQuery.noConflict();
//--------
//Koder
//--------
jq(function() {
	jq('#codeList').on('click', 'td', function() {
		var id = this.id;
		var record = id.split('@');
		var code = record[0].replace("code", "");
		var description = record[1].replace("description", "");
		var caller = record[2].replace("caller", "");

		caller = "#" + caller;
		
		if (caller == '#arsban') {
			opener.jq(caller).val(description);			
		} else {
			opener.jq(caller).val(code);
		}
		opener.jq(caller).change();
		opener.jq(caller).focus();
		
		window.close();
	});
});

//======================
//Datatables jquery 
//======================
//private function [Filters]
function filterCode() {
	jq('#codeList').DataTable().search(jq('#codeList_filter').val()).draw();
}
//Init datatables
jq(document).ready(function() {
	var lang = opener.jq('#language').val();
	jq('#codeList').dataTable({
		"dom" : '<"top"fli>rt<"bottom"p><"clear">',
		"lengthMenu" : [ 75, 100, 200, 500 ],
		"language": {
			"url": getLanguage(lang)
        }
	});
	//event on input field for search
	jq('input.codeList_filter').on('keyup click', function() {
		filterCode();
	});

});
