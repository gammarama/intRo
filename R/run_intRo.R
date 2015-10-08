#' Run a local instance of intRo
#' 
#' @param path The directory containing the intRo folder
#' @param enabled_modules The modules to enable
#' @param theme The shinythemes theme to use
#' @param ... Additional arguments passed to the Shiny runApp function
#' 
#' @export
#' 
#' @importFrom shiny runApp
#' 
#' @examples
#' \dontrun{
#'     run_intRo()
#'     run_intRo(enabled_modules = c("data/transform", "summaries/graphical"),
#'               theme = "cerulean")
#' }
run_intRo <- function(path = getwd(), enabled_modules = NULL, theme = NULL, ...) {
    path <- file.path(path, "intRo")
    
    if (is.null(enabled_modules)) enabled_modules <- c("data/transform", 
                                                       "summaries/graphical",
                                                       "summaries/numerical",
                                                       "statistics/contingency",
                                                       "statistics/regression",
                                                       "statistics/t_test")
    if (is.null(theme)) theme <- "united"
    
    intRo_configuration <- list(intRo_enabled_modules = enabled_modules,
                                intRo_theme = theme)
    save(intRo_configuration, file = file.path(path, "data", "configuration.rda"))
    
    runApp(path, ...)
}
