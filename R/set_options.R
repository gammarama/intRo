#' Set the options for the given intRo instance
#' 
#' @param path The directory containing the intRo folder
#' @param enabled_modules The modules to enable
#' @param theme The shinythemes theme to use
#' 
#' @examples
#' \dontrun{
#'     deploy_intRo()
#' }
set_options <- function(path, enabled_modules, theme) {
    if (!file.exists(file.path(path, "data", "configuration.rda"))) stop("Could not find intRo.")
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
}
