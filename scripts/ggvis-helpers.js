function clear_ggvis() {
  var ggvis_output = $('.ggvis-output');
  ggvis_output.children().remove();
  ggvis_output.removeAttr('style');
  ggvis_output.parents().filter('.ui-resizable[style]').removeAttr('style');
  console.log("cleared");
}

function wait_clear() {
    if ( Shiny.shinyapp) {
      if(Shiny.shinyapp.$inputValues.xreg == '' & Shiny.shinyapp.$inputValues.x == '') {
        clear_ggvis();
      }
      else {
        setTimeout( wait_clear, 500 );
      }
    } else {
        setTimeout( wait_clear, 500 );
    }
}

function invisible_gears() {
  var toggles = $('.ggvis-dropdown-toggle'); 
  toggles.hide();
  toggles.prop("disabled",true);  
}

$( document ).ready(function() { 
  invisible_gears();   
});
