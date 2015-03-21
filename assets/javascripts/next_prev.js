function manageNextPrev() {
   $('a#next').parent().toggleClass('disabled', $('.nav-pills li.active').nextAll('li:not(.navbar-brand, .divider)').size() == 0);
   $('a#previous').parent().toggleClass('disabled', $('.nav-pills li.active').prevAll('li:not(.navbar-brand, .divider)').size() == 0);  

	//get active link
	var act = $('#sidebar .active a').attr("href");
	act = act.substring(1, act.length);
  
	//set only active to visible
	$('#main article').css("display", "none");
	$('#main article[id="'+act+'"]').css("display", "block");
}

$('li:not(.disabled) a#next').click(function(e) {
   e.preventDefault();
   var active_nav = $('.nav-pills li.active');
   if(active_nav.nextAll('li:not(.navbar-brand, .divider)').first().find('a').attr('href')) { 	location.href = active_nav.nextAll('li:not(.navbar-brand, .divider)').first().find('a').attr('href');
   
   //set nav active
   active_nav.toggleClass("active");
   active_nav.nextAll('li:not(.navbar-brand, .divider)').first().toggleClass("active");
   
   manageNextPrev();
   } else {
		return;
   }
});

$('li:not(.disabled) a#previous').click(function(e) {
   e.preventDefault();
   var active_nav = $('.nav-pills li.active');
   if(active_nav.prevAll('li:not(.navbar-brand, .divider)').first().find('a').attr('href')) { location.href = active_nav.prevAll('li:not(.navbar-brand, .divider)').first().find('a').attr('href');
   
   //set nav active
   active_nav.toggleClass("active");
   active_nav.prevAll('li:not(.navbar-brand, .divider)').first().toggleClass("active");
   
   manageNextPrev();
   } else {
	   return;
   }
});

manageNextPrev() 
