//JavaScript for hacking around the default behavior of Shiny

$("#top-nav a[data-value]").each(function() {
    // this references the DOM element and we change its 'href' attribute.
    this.setAttribute('href', this.getAttribute('data-value'));
    this.setAttribute('target', '_blank');
    this.setAttribute('data-toggle', null)
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

$('#myEditor').css("display", "none");
