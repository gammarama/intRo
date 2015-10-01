download_intRo <- function(path = NULL) {
    if (is.null(path)) {
        message("Downloading intRo to ", getwd(), "/intRo")
        path <- file.path(getwd(), "intRo")
    }
    git2r::clone("https://github.com/gammarama/intRo", local_path = path)
}

run_intRo <- function(path = NULL, enabled_modules = NULL, theme = "united") {
    if (is.null(path)) path <- file.path(getwd(), "intRo")
    
    assign("intRo_enabled_modules", enabled_modules, envir = globalenv())
    assign("intRo_theme", theme, envir = globalenv())
    
    shiny::runApp(path)
}

download_intRo()
run_intRo()
run_intRo(enabled_modules = c("data/transform", 
                              "summaries/graphical"),
          theme = "cerulean")
