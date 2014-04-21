function manageNextPrev() {
   $('a#next').parent().toggleClass('disabled', $('.nav-list li.active').nextAll('li:not(.nav-header, .divider)').size() == 0);
   $('a#previous').parent().toggleClass('disabled', $('.nav-list li.active').prevAll('li:not(.nav-header, .divider)').size() == 0);   

	//get active link
	var act = $('#sidebar .active a').attr("href");
	act = act.substring(1, act.length);
  console.log(act)
	//set only active to visible
	/*$('#main article').css("display", "none");
	$('#main article[id="'+act+'"]').toggle("fast");*/
}

$('a#next').click(function(e) {
   e.preventDefault();
   var active_nav = $('.nav-list li.active');
   location.href = active_nav.nextAll('li:not(.nav-header, .divider)').first().find('a').attr('href');
   
   //set nav active
   active_nav.toggleClass("active");
   active_nav.nextAll('li:not(.nav-header, .divider)').first().toggleClass("active");
   
   manageNextPrev();
});

$('a#previous').click(function(e) {
   e.preventDefault();
   var active_nav = $('.nav-list li.active');
   location.href = active_nav.prevAll('li:not(.nav-header, .divider)').first().find('a').attr('href');
   
   //set nav active
   active_nav.toggleClass("active");
   active_nav.prevAll('li:not(.nav-header, .divider)').first().toggleClass("active");
   
   manageNextPrev();
});

manageNextPrev() 
