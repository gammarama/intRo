var content;

function code_clicked() {
    Shiny.onInputChange("code_clicked", $('a:has(> .fa-code)').parent().hasClass("active"));
}

function download_clicked() {
    $( "#mydownload").trigger("click")
}

function print_clicked() {
    code_clicked();
    Shiny.onInputChange("print_clicked", true);
}

Shiny.addCustomMessageHandler("renderFinished",
  function(file) {
    var frame = $('.print_results');
    //frame.contents().find("html").html(file);
    frame.attr('src', 'code_All.html');

    content = frame.contents().find("body").html();
    check_print(frame);
  });

function check_print(frame) {
  if (frame.contents().find("body").html() == content) {
    setTimeout(check_print, 500, frame);
  } else {
    $('.print_results').get(0).contentWindow.print();
    Shiny.onInputChange("print_clicked", false);
  }    
}
