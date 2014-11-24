function print_clicked() {
    console.log("clicked!")
    Shiny.onInputChange("print_clicked", true);
    $('.print_results').attr('src','code_All.html');
    $('.print_results').get(0).contentWindow.print();
     Shiny.onInputChange("print_clicked", false);
}