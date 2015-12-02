//JavaScript for hacking around the default behavior of Shiny

$("#top-nav a[data-value]").each(function() {
	// this references the DOM element and we change its 'href' attribute.
	if(this.getAttribute('data-value').substring(0,4) == 'java') {
		this.setAttribute('onClick', this.getAttribute('data-value'))
		this.setAttribute('data-toggle', null);
	} else if(this.getAttribute('data-value').substring(0,4) == 'http'){
		this.setAttribute('href', this.getAttribute('data-value'));
		this.setAttribute('target', '_blank');
		this.setAttribute('data-toggle', null);
	}
});

//extra hacky for dropdown href set
var eric_dd = $('.dropdown-menu a:contains("Eric Hare")');
eric_dd.attr("href", "http://erichare.net");
eric_dd.attr("data-toggle", null);
eric_dd.attr("target", "_blank");

var andee_dd = $('.dropdown-menu a:contains("Andee Kaplan")');
andee_dd.attr("href", "http://andeekaplan.com");
andee_dd.attr("data-toggle", null);
andee_dd.attr("target", "_blank");

$('.fa-code').parent().parent().toggleClass('active');

$('a:contains("hide_me")').parent().parent().parent().css("width", "100%");

var space_width = (
$('.container').innerWidth() - 
$('.brand').outerWidth() -
eval($('.navbar a').map(function(){
    return $(this).parent().width();
}).get().join("+")) + 
$('a:contains("hide_me")').parent().width() - 94);

//spacing of navbar
$('a:contains("hide_me")').css("visibility", "hidden");
$('a:contains("hide_me")').parent().css("width", space_width);
