jQuery.fn.highlight = function() {
  $(this).each(function() {
        var el = $(this);
        el.before("<div/>")
        el.prev()
            .width(el.outerWidth())
            .height(el.outerHeight())
            .css({
                "position": "absolute",
                "background-color": "#ffff99",
                "opacity": ".5"   
            })
            .fadeOut(1000);
    });
}

//call with $('#side-nav :contains("Sources")').highlight()
