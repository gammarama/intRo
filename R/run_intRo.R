#' Run a local instance of intRo
#' 
#' @param path The directory containing the intRo folder
#' @param enabled_modules The modules to enable
#' @param theme The shinythemes theme to use
#' @param ... Additional arguments passed to the Shiny runApp function
#' @export
#' @importFrom shiny runApp
#' @examples
#' \dontrun{
#'     run_intRo()
#'     run_intRo(enabled_modules = c("data/transform", "summaries/graphical"),
#'               theme = "cerulean")
#' }
run_intRo <- function(path = getwd(), enabled_modules = NULL, theme = NULL, ...) {
    path <- file.path(path, "intRo")
    
    set_options(path, enabled_modules, theme, google_analytics = NULL)
    
    runApp(path, ...)
}
