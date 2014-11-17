var outputBinding = new Shiny.OutputBinding();
$.extend(outputBinding, {
  find: function(scope) {
    return $(scope).find('.print-results');
  },
  renderValue: function(el, data) {  
    render_print(el, data);
  }});
Shiny.outputBindings.register(outputBinding);

var inputBinding = new Shiny.InputBinding();
$.extend(inputBinding, {
  find: function(scope) {
    return $(scope).find('.print-button');
  },
  getValue: function(el) {
    return null;
  },
  subscribe: function(el, callback) {
    $(el).on("click", function(e) {
      callback();
    });
  },
});
Shiny.inputBindings.register(inputBinding);

render_print = function(el, data) {
  $(el).text(data);
}

print_intRo = function() {
  $( ".print-results" ).dialog({
    modal: true,
    buttons: {
      Print: function() {
        //print stuff
        $( this ).dialog( "close" );
      }
    }
  });
}