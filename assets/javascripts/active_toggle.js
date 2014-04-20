
function set_visible() {
	//get active link
	var act = $('#sidebar .active a').attr("href");
	act = act.substring(1, act.length);

	//set only active to visible
	$('#main article').css("display", "none");
	$('#main article[id="'+act+'"]').toggle("fast");
	
	manageNextPrev() 
}
